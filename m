Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:13695 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906Ab1DODOe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Apr 2011 23:14:34 -0400
Received: from wpaz33.hot.corp.google.com (wpaz33.hot.corp.google.com [172.24.198.97])
	by smtp-out.google.com with ESMTP id p3F3EX9L001195
	for <linux-watchdog@vger.kernel.org>; Thu, 14 Apr 2011 20:14:33 -0700
Received: from yxn22 (yxn22.prod.google.com [10.190.4.86])
	by wpaz33.hot.corp.google.com with ESMTP id p3F3EHQE013686
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Thu, 14 Apr 2011 20:14:32 -0700
Received: by yxn22 with SMTP id 22so1168290yxn.20
        for <linux-watchdog@vger.kernel.org>; Thu, 14 Apr 2011 20:14:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110415024005.GA21642@ericsson.com>
References: <1302816996-6345-1-git-send-email-natg@google.com>
	<1302817069-6389-1-git-send-email-natg@google.com>
	<1302821370.26780.585.camel@groeck-laptop>
	<BANLkTin6M0R4d+HMovbRwqthSHowUEKFow@mail.gmail.com>
	<20110415024005.GA21642@ericsson.com>
Date: Thu, 14 Apr 2011 20:14:32 -0700
Message-ID: <BANLkTi=t+AgRU47DhKoGOJ2mTa6AVfaPVw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] Use "request_muxed_region" in it87 watchdog drivers
From: Natarajan Gurumoorthy <natg@google.com>
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Mike Waychison <mikew@google.com>,
	"lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Apr 14, 2011 at 7:40 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> Unless I am missing something, the problem is that there is another driver
> calling request_region() instead of request_muxed_region().
>
> w83697hf_check_wdt() (and other drivers doing the same) should call
> request_muxed_region(). Otherwise, the same problem could happen with the
> caller(s) of request_region() - those calls could fail as well.
> Plus, other callers of request_muxed_reason() not implementing
> your retry code could end up with the same problem, ie with spurious failures.
>
> I think we will have to find a solution which does not require retries
> when calling request_muxed_region(). On the other side, others know
> this code much better than I do, so maybe someone has a better solution.
>
Guenter,
    Your conclusion is on the money. request_muxed_region will fail if
someone else called request_region for the same region. The knife cuts
both ways and reguest_region will fail when a request_muxed_region
calll has been made for the same zone.  I am not sure what happens
when the second driver calls request_muxed_region for only part of the
region that has been reserved by another driver. This is of course one
of the problems. The other problem is that there are drivers which
don't call either of those 2 interfaces and just go ahead and clobber
the 0x2e 0x2f zone because they think they own all of it. I created a
list drivers in hwmon and watchdog directories that need to be fixed
in one of my earlier emails. John Delvare replied that are other
drivers in parport that all need fixing. I got started on this because
we use 2 different it87 drivers (hwmon/it87.c and
watchdog/it8712f_wdt.c) concurrently and had to solve this problem.

Regards
Nat


> Thanks,
> Guenter
>



-- 
Regards
Nat Gurumoorthy AB6SJ
