Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 123.103.51.227-BJ-CNC ([123.103.51.227]:34125 "EHLO wangsu.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725968AbeLDDb0 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 3 Dec 2018 22:31:26 -0500
From: Lin Feng <linf@wangsu.com>
Subject: x86_64 NMI watchdog false positive, watchdog_overflow_callback fires
 at random period
To: linux-watchdog@vger.kernel.org
Cc: wim@linux-watchdog.org, linux@roeck-us.net
Message-ID: <56fbb89e-d49d-7bcb-84c7-37f5c3d5a15d@wangsu.com>
Date: Tue, 4 Dec 2018 11:14:28 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi all,

Would you please do me a favor, I google a lot but haven't got any useful information.

My server equips with Intel(R) Xeon(R) CPU E5-2650 0 @ 2.00GHz CPU, after updated kernel from
2.6.32-358 to 3.10-693(centos release kernels), there are many servers panic by nmi hard lockup.
I found that it's a 'false positive', interrupt has never been disabled longer than hundreds
milliseconds. But watchdog_overflow_callback fires too often, as shown the in following log,
@97919.297501 time stamp, kernel sends a nmi warning(disable hardlockup_panic) and at exact this
second interval, watchdog_overflow_callback shot twice, which is much faster than
watchdog_timer_fn's period.
---
   Message from syslogd@zhengzdx26 at Nov 30 14:53:48 ...
   kernel:[97919.297501] NMI watchdog: Watchdog detected hard LOCKUP on cpu 8

             squid-12576 [008] d.h. 97557.301384: watchdog_overflow_callback <-__perf_event_overflow
             squid-12818 [008] d.h. 97623.930167: watchdog_overflow_callback <-__perf_event_overflow
           haproxy-16868 [008] d.h. 97658.308772: watchdog_overflow_callback <-__perf_event_overflow
             squid-19961 [008] d.h. 97679.347461: watchdog_overflow_callback <-__perf_event_overflow
           haproxy-16870 [008] d.h. 97746.912428: watchdog_overflow_callback <-__perf_event_overflow
             squid-20037 [008] d.h. 97778.363767: watchdog_overflow_callback <-__perf_event_overflow
           haproxy-16869 [008] d.h. 97847.725242: watchdog_overflow_callback <-__perf_event_overflow
             squid-12817 [008] d.h. 97868.908962: watchdog_overflow_callback <-__perf_event_overflow
             squid-12729 [008] d.h. 97893.879844: watchdog_overflow_callback <-__perf_event_overflow
             squid-12818 [008] d.h. 97919.190085: watchdog_overflow_callback <-__perf_event_overflow
             squid-12858 [008] d.h. 97919.297498: watchdog_overflow_callback <-__perf_event_overflow
---

After diving into the source I know that the watchdog_thresh is changed from 60 to 10 in new kernels.
Based on this patch:
'https://gitlab.ic.unicamp.br/lkcamp/linux-staging/commit/4eec42f392043063d0f019640b4ccc2a45570002'

	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
	event = perf_event_create_kernel_counter(wd_attr, cpu, NULL, watchdog_overflow_callback);

IIUC watchdog_overflow_callback should be fired in a period of hw_nmi_get_sample_period(watchdog_thresh).
But as the trace log shown, the period is not regular at all, most of the interval is longer than
watchdog_thresh, this also happens in my desktop 4.18.14-200.fc28.x86_64, maybe it's about nohz quirk?
And even worse is that sometimes watchdog_overflow_callback gets called twice in a second, which making
a 'false positive', So what's the problem?

Best regards and Thanks,
linfeng
