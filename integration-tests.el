(require 'ert)

(add-to-list 'load-path ".")
(load "org-cliplink.el")
(load "org-cliplink-jira.el")

(ert-deftest cliplink-simple-title-by-http ()
  (let ((url "http://127.0.0.1:8001/http.html")
        (expected-outcome "[[http://127.0.0.1:8001/http.html][Hello World]]")
        (timeout 5))
    (with-temp-buffer
      (kill-new url)
      (org-cliplink)
      (sleep-for timeout)
      (should (equal (buffer-string) expected-outcome)))))

(ert-deftest cliplink-html4-entity-escaping ()
  (let ((url "http://127.0.0.1:8001/html4-escaping.html")
        (expected-outcome "[[http://127.0.0.1:8001/html4-escaping.html][&{Hello} '{World} α  ]]")
        (timeout 5))
    (with-temp-buffer
      (kill-new url)
      (org-cliplink)
      (sleep-for timeout)
      (should (equal (buffer-string) expected-outcome)))))

(ert-deftest cliplink-simple-title-by-https ()
  (let ((url "https://127.0.0.1:4443/http.html")
        (expected-outcome "[[https://127.0.0.1:4443/http.html][Hello World]]")
        (timeout 5))
    (with-temp-buffer
      (kill-new url)
      (org-cliplink)
      (sleep-for timeout)
      (should (equal (buffer-string) expected-outcome)))))

(ert-deftest cliplink-simple-title-by-gziped-http ()
  (let ((url "http://127.0.0.1:8002/http.html")
        (expected-outcome "[[http://127.0.0.1:8002/http.html][Hello World]]")
        (timeout 5))
    (with-temp-buffer
      (kill-new url)
      (org-cliplink)
      (sleep-for timeout)
      (should (equal (buffer-string) expected-outcome)))))

(ert-deftest cliplink-complex-test ()
  (let ((url "https://127.0.0.1:4444/html4-escaping.html")
        (expected-outcome "[[https://127.0.0.1:4444/html4-escaping.html][&{Hello} '{World} α  ]]")
        (timeout 5))
    (with-temp-buffer
      (kill-new url)
      (org-cliplink)
      (sleep-for timeout)
      (should (equal (buffer-string) expected-outcome)))))

(ert-deftest cliplink-jira-support ()
  (let ((jira-id "CLIPLINK-6222")
        (expected-outcome "[[https://127.0.0.1:4444/jira/browse/CLIPLINK-6222][(CLIPLINK-6222) JIRA support]]")
        (timeout 5)
        (org-cliplink-secrets-path "./test-data/secrets/org-cliplink-jira-secrets.el"))
    (with-temp-buffer
      (kill-new jira-id)
      (org-cliplink-jira)
      (sleep-for timeout)
      (should (equal (buffer-string) expected-outcome)))))

(ert-run-tests-batch-and-exit)
