;;; -*- lexical-binding: t; -*-

(defvar rescript2-mode-syntax-table
  (let ((table (make-syntax-table)))

    ;; Operators
    (dolist (i '(?+ ?- ?* ?/ ?& ?| ?^ ?! ?< ?> ?=))
      (modify-syntax-entry i "." table))

    ;; Symbols
    (modify-syntax-entry ?@ "_" table)
    (modify-syntax-entry ?~ "_" table)
    (modify-syntax-entry ?# "_" table)

    ;; Strings
    (modify-syntax-entry ?\" "\"" table)
    (modify-syntax-entry ?\\ "\\" table)
    (modify-syntax-entry ?\' "_"  table)
    (modify-syntax-entry ?\` "\"" table)

    ;; Comments
    (modify-syntax-entry ?\/  ". 124b" table)
    (modify-syntax-entry ?\*  ". 23n"  table)
    (modify-syntax-entry ?\n  "> b"    table)
    (modify-syntax-entry ?\^m "> b"    table)

    ;; Quoted variable names
    (modify-syntax-entry ?\\ "\\ p" table)

    table))

(defvar rescript--treesit-settings
  (treesit-font-lock-rules
   :feature 'comment
   :language 'rescript
   '((comment) @font-lock-comment-face)

   :feature 'string
   :language 'rescript
   '((template_string) @font-lock-string-face
     (string_fragment) @font-lock-string-face
     (string) @font-lock-string-face
     (string) @contextual) ; Contextual special treatment.

   :feature 'let-id
   :language 'rescript
   '((value_identifier) @font-lock-function-name-face)

   :feature 'module-id
   :language 'rescript
   '((module_identifier) @font-lock-type-face)

   :feature 'jsx-tag
   :language 'rescript
   '((jsx_identifier) @font-lock-type-face)

   :feature 'polyvar-id
   :language 'rescript
   '((polyvar_identifier "#") @font-lock-builtin-face)

   :feature 'variant-id
   :language 'rescript
   '((variant_identifier) @font-lock-type-face)

   :feature 'decorator-id
   :language 'rescript
   '((decorator_identifier) @font-lock-preprocessor-face)

   :feature 'extension
   :language 'rescript
   '((extension_expression
      "%" @font-lock-builtin-face
      (extension_identifier) @font-lock-builtin-face))

   :feature 'constant
   :language 'rescript
   '(((true) @font-lock-constant-face)
     ((false) @font-lock-constant-face))

   :feature 'type
   :language 'rescript
   '((type_identifier) @font-lock-builtin-face)

   ;; :feature 'builtin-type
   ;; :language 'rescript
   ;; '(["int" "float" "string" "char" "bool" "unit" "list" "array" "exn"
   ;;    "option" "ref" "result" "promise"]
   ;;   @font-lock-builtin-face)

   ;; (value_identifier) &&
   ;; `(["FILE" "LINE" "LINE_OF" "LOC" "LOC_OF" "MODULE" "POS" "POS_OF"]
   ;;   @font-lock-constant-face)

   :feature 'keyword
   :language 'rescript
   '(["and" "as" "assert" "async" "await" "constraint" "catch" "downto"
      "else" "exception" "external" "for" "if" "in" "include" "lazy"
      "let" "module" "mutable" "of" "open" "rec" "switch" "to" "try"
      "type" "when" "while" "with"]
     @font-lock-keyword-face)
   ))

(defun match-field-parent-sibling (node-field parent-type sibling-field sibling-type)
  (lambda (node parent &rest _)
    (and
     (aand (treesit-node-field-name node) (string-match-p node-field it))
     (aand (treesit-node-type parent) (string-match-p parent-type it))
     (aand (treesit-node-type
            (treesit-node-child-by-field-name parent sibling-field))
           (string-match-p sibling-type it)))))

(defvar rescript--treesit-indent-rules
  '((rescript
     ((node-is ")") parent-bol 0)
     ((node-is "]") parent-bol 0)
     ((node-is "}") parent-bol 0)
     ((node-is "|") parent-bol 0) ;; needed?

     ;; ((n-p-gp nil "record" "expression_statement") parent-bol 4)

     ((node-is "jsx_closing_element") parent 0)
     ((parent-is "jsx_element") parent 2)
     ((parent-is "jsx_expression") parent 2)
     ((parent-is "jsx_opening_element") parent 2)
     ((match nil "jsx_self_closing_element" "attribute") prev-sibling 0)

     ((node-is "->") parent-bol 0)
     ((node-is "?") parent-bol 2)
     ((node-is ":") parent-bol 2)
     ((match nil "ternary_expression" "alternative") prev-sibling 0)
     ((match nil "ternary_expression" "consequence") prev-sibling 0)

     ((parent-is "type_binding") parent-bol 2)
     ((parent-is "let_binding") parent-bol 2)

     ((parent-is "formal_parameters") parent-bol 2)
     ((parent-is "arguments") parent-bol 2)
     ((parent-is "array") parent-bol 2)
     ((parent-is "block") parent-bol 2)
     ((parent-is "function") parent-bol 2)
     ((node-is "variant_type") parent-bol 2)
     ((node-is "polyvar_type") parent-bol 2)
     ((node-is "switch_match") parent-bol 0)
     ((node-is "sequence_expression") parent-bol 2)
     ((parent-is "extension_expression") parent-bol 2)
     ((parent-is "parenthesized_expression") parent-bol 2)
     ((parent-is "object") parent-bol 2)
     ((parent-is "record") parent-bol 2)
     ((parent-is "record_type") parent-bol 2)

     ((match-field-parent-sibling "right" "binary_expression" "operator" "==") parent 2)
     ((match nil "binary_expression" "right") prev-sibling 0)

     (no-node parent-bol 0)))
  )

(defvar rescript2-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c <tab>") #'rescript-format-buffer)
    map))

(define-derived-mode rescript2-mode prog-mode "Res2"
  "Major mode for ReScript code.

\\{rescript-mode-map}"
  :group 'rescript2
  :syntax-table rescript2-mode-syntax-table
  :map rescript2-mode-map

  ;; Misc
  (setq-local comment-start "/* ")
  (setq-local comment-end   " */")
  (setq-local indent-tabs-mode nil)

  ;; Allow paragraph fills for comments
  (setq-local comment-start-skip "/\\*+[ \t]*")
  (setq-local paragraph-start
              (concat "^[ \t]*($\\|\\*)$\\|" page-delimiter))
  (setq-local paragraph-separate paragraph-start)
  (setq-local require-final-newline t)
  (setq-local normal-auto-fill-function nil)
  (setq-local comment-multi-line t)
  (setq-local indent-line-function 'indent-relative)
  (setq-local comment-auto-fill-only-comments t)
  (setq-local fill-column 80)
  (setq-local fill-paragraph-function 'rescript2-fill-paragraph)

  ;; Treesit
  (require 'treesit)
  (treesit-parser-create 'rescript)
  (setq-local treesit-font-lock-settings rescript--treesit-settings)
  (setq-local treesit-simple-indent-rules rescript--treesit-indent-rules)
  (setq-local treesit-font-lock-feature-list
              '((comment string keyword jsx-tag module-id polyvar-id decorator-id variant-id type constant extension)
                (type-name let-name)))
  (treesit-major-mode-setup)

  (lsp t)
  (setq-local lsp-response-timeout 2)
  (setq-local lsp-ui-doc-delay 0.6)

  (company-mode t)
  (setq-local company-minimum-prefix-length 2)
  (setq-local company-idle-delay 0.6))

(with-eval-after-load 'treesit
  (add-to-list 'treesit-extra-load-path "/home/carl/git/tree-sitter-rescript"))

(add-to-list 'auto-mode-alist '("\\.resi?$" . rescript2-mode))

(defun my/treesit-bol (node)
  (save-excursion
    (goto-char (treesit-node-start node))
    (beginning-of-line)
    (point)))

(defun my/treesit-substring (node beg end)
  (buffer-substring-no-properties
   (+ (treesit-node-start node) beg)
   (+ (treesit-node-start node) end)))

(defun my/treesit-column (node)
  (save-excursion
    (goto-char (treesit-node-start node))
    (current-column)))

(defun rescript2-fill-paragraph (&optional arg)
  (interactive "*P")
  (let* ((node (treesit-node-at (point)))
         (fill-prefix (if (equal (my/treesit-substring node 0 2) "//")
                          (concat (s-repeat (my/treesit-column node) " ") "// ")
                        (s-repeat (+ 3 (my/treesit-column node)) " "))))
    (when (equal (treesit-node-type node) "comment")
      (fill-region (treesit-node-end node) (treesit-node-start node)))))
