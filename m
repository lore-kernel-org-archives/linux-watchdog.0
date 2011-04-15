Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:4034 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036Ab1DOBTB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Apr 2011 21:19:01 -0400
Received: from kpbe11.cbf.corp.google.com (kpbe11.cbf.corp.google.com [172.25.105.75])
	by smtp-out.google.com with ESMTP id p3F1IxlT017139
	for <linux-watchdog@vger.kernel.org>; Thu, 14 Apr 2011 18:18:59 -0700
Received: from ywf7 (ywf7.prod.google.com [10.192.6.7])
	by kpbe11.cbf.corp.google.com with ESMTP id p3F1IrZg020425
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Thu, 14 Apr 2011 18:18:58 -0700
Received: by ywf7 with SMTP id 7so83357ywf.13
        for <linux-watchdog@vger.kernel.org>; Thu, 14 Apr 2011 18:18:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1302821370.26780.585.camel@groeck-laptop>
References: <1302816996-6345-1-git-send-email-natg@google.com>
	<1302817069-6389-1-git-send-email-natg@google.com>
	<1302821370.26780.585.camel@groeck-laptop>
Date: Thu, 14 Apr 2011 18:18:57 -0700
Message-ID: <BANLkTin6M0R4d+HMovbRwqthSHowUEKFow@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] Use "request_muxed_region" in it87 watchdog drivers
From: Natarajan Gurumoorthy <natg@google.com>
To: guenter.roeck@ericsson.com
Cc: Jean Delvare <khali@linux-fr.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Mike Waychison <mikew@google.com>,
	"lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Apr 14, 2011 at 3:49 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> This is way too complicated. Just return an error if
> request_muxed_region fails, like all other callers of
> request_muxed_region do.
>
Guenter,
      This maybe a little complicated but it is a solution that will
correctly deal with the following scenario:
      Hardware: it8712f
      cpu: Multicore
      kernel: smp
      Modules being loaded during initialization: it8712f_wtd and w83697hf

The problem is one of the cores is halfway through initializing
it8712f_wdt and another core is just starting to run the
"w83697hf_check_wdt" which is going to call "request_region" to
reserve 0x2e 0x2f region. Just after that call on the other core
it8712f_wdt_init calls it8712f_wdt_disable which calls superio_enter
which will call "request_muxed_region" for the exact same region. This
is  guaranteed to fail because as of now w83697hf is one of the many
non compliant drivers who are calling "request_region". The w83697hf
will do the probe and conclude there is no w83697hf chip in the system
and abort rest of the driver initialization. Meanwhile the it8712f_wtd
driver initialization will fail. This will be one of those
intermittent failures that make most kernel device driver writers
prematurely bald :-).

The way I have reworked the driver will survive the above scenario.

Regards
Nat

> Guenter
>
>
>



-- 
Regards
Nat Gurumoorthy AB6SJ
