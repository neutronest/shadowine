;;; package --- Summary

;;; Copyright 2015 neutronest

;;; Commentary:

;; this plugin is just a special calendar created for experience observing
;; in a lifelong time.

;;; Code:
(require 'time)

;;; thirdparty library
(require 'pcase)


(defvar  title-time-mode t
  "A flag.")

;; (setq origin_time "Monday, 10-10-2011, 00:00:00")
;; (setq origin_time (date-to-time "Mon-Oct-11 12:35:59 EST"))



(defun shadowine-transfor()
  "the transfor caculate from Gregorian"
  (interactive)
  (let*
      ((origin_time (encode-time 0 0 0 01 01 2012))
       (last_time (float-time (time-subtract (current-time) origin_time)))

       ;; annals
       (annals_now (format-seconds "%Y" last_time))
       (sha_annals (pcase annals_now
                   ("3 years" "洋化纪初年")
                   ("4 years" "洋化纪渐年")
                   ("5 years" "东瀛纪初年")
                   ("6 years" "东瀛纪渐年")
                   ))
       ;; Trace, month
       (month_now (string-to-number (format-time-string "%m")))
       (sha_trace (pcase month_now
                    (1 "冰晨迹")
                    (2 "冰晨迹")
                    (3 "樱岚迹")
                    (4 "樱岚迹")
                    (5 "赤兴迹")
                    (6 "赤兴迹")
                    (7 "阳炽迹")
                    (8 "阳炽迹")
                    (9 "秋华迹")
                    (10 "秋华迹")
                    (11 "寒明迹")
                    (12 "寒明迹")
                    ))

       (sha_month (pcase (mod month_now 2)
                    (1 "初月")
                    (0 "渐月")
                    ))
       ;; rank
       (day_now (string-to-number (format-time-string "%d")))
       ;;(sha_rank (pcase day_now
                  ;; ((pred (< 8)) "初秩初曜")
                  ;; ((pred (< 15)) "初秩渐曜")
                  ;; ((pred (< 22)) "渐秩初曜")
                  ;; ((pred (< 29)) "渐秩渐曜")
                  ;; ((pred (< 32)) "渐秩盈曜")
                  ;; ))

       (sha_rank (cond
                  ((< day_now 8)  "初秩初曜")
                  ((< day_now 15) "初秩渐曜")
                  ((< day_now 22) "渐秩初曜")
                  ((< day_now 29) "渐秩渐曜")
                  ((< day_now 32) "渐秩盈曜")
                  ))
       ;; week
       (week_now (format-time-string "%w"))
       (sha_week (pcase week_now
                   ("1" "月")
                   ("2" "火")
                   ("3" "水")
                   ("4" "木")
                   ("5" "金")
                   ("6" "土")
                   ("0" "日")
                   ))
       ;; moment
       (hour_now (string-to-number (format-time-string "%H")))
       (sha_moment (cond
                    ( (and (>= hour_now 6) (< hour_now 14))  "昼刻时")
                    ( (and (>= hour_now 14) (< hour_now 22)) "华刻时")
                    ( (or (>= hour_now 22) (< hour_now 6)) "暗刻时")
                    )))
    (concat

     sha_annals
     sha_trace
     sha_month
     sha_rank
     sha_week
     sha_moment
     )))


(defun test1()

  (let*
      (
       (sha_rank (pcase
                   ((pred (> 8)) "初秩初曜")
                   ((pred (< 15)) "初秩渐曜")
                   ((pred (< 22)) "渐秩初曜")
                   ((pred (< 29)) "渐秩渐曜")
                   ((pred (< 32)) "渐秩盈曜")
                   ))
       )
    sha_rank
    )
  )

(defun shadowine-calendar()
  "caculate the time from origin time to now"
  (interactive)
  (let*
      ((origin_time (encode-time 0 0 0 01 01 2012))
       (_last_time (time-subtract (current-time) origin_time))
       (last_time (float-time _last_time)))
    (format "Normalized time %d days; %.2f months; %.2f weeks; -- %s"
            (floor (/ last_time 86400))
            (/ last_time 2628000)
            (/ last_time 604800)
            (format-seconds "%Y, %D, %H, %M%z" last_time)
            )))

(display-time-mode 1)
(provide 'shadowine)
;;; shadowine ends here
