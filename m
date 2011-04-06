Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:35178 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816Ab1DFVpY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 6 Apr 2011 17:45:24 -0400
Received: from kpbe19.cbf.corp.google.com (kpbe19.cbf.corp.google.com [172.25.105.83])
	by smtp-out.google.com with ESMTP id p36LjNA5032147
	for <linux-watchdog@vger.kernel.org>; Wed, 6 Apr 2011 14:45:23 -0700
Received: from yie12 (yie12.prod.google.com [10.243.66.12])
	by kpbe19.cbf.corp.google.com with ESMTP id p36LiuW1014392
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 6 Apr 2011 14:45:22 -0700
Received: by yie12 with SMTP id 12so860508yie.13
        for <linux-watchdog@vger.kernel.org>; Wed, 06 Apr 2011 14:45:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BANLkTimeAh3pm=Z73hYPPfAJfu8J5=tPpw@mail.gmail.com>
References: <1302038697-28985-1-git-send-email-natg@google.com>
	<20110405223814.GA21350@ericsson.com>
	<BANLkTimQDVYe53K-M173iQtmkHzKg6Djyg@mail.gmail.com>
	<20110406000528.GB21350@ericsson.com>
	<BANLkTi==zj3PoNuqf2=THaHzevvHHsuh=w@mail.gmail.com>
	<20110406004312.GA21882@ericsson.com>
	<BANLkTinSAOxNkjxMGewfPUc0-bjf9MesGA@mail.gmail.com>
	<20110406030220.GB22535@ericsson.com>
	<BANLkTimTfWrx-ezyerRTtZHrLdOOf2V19w@mail.gmail.com>
	<BANLkTimeAh3pm=Z73hYPPfAJfu8J5=tPpw@mail.gmail.com>
Date: Wed, 6 Apr 2011 14:45:21 -0700
Message-ID: <BANLkTinT1td=kovSFRu=j5-qwHJ7na6v0Q@mail.gmail.com>
Subject: Re: [PATCH] Make all it87 drivers SMP safe.
From: Natarajan Gurumoorthy <natg@google.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>,
	Jean Delvare <khali@linux-fr.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Mike Waychison <mikew@google.com>,
	"lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Paul,
     Comments are below.

On Wed, Apr 6, 2011 at 2:35 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> On Wed, Apr 6, 2011 at 3:04 AM, Natarajan Gurumoorthy <natg@google.com> wrote:
>> Guenter,
>>      Thank you for your feedback. I found an easier way to deal with
>> the it87_lock.c file. I do not need to move it to the driver/misc
>> directory. The easier thing to do was to move the IT87_LOCK entry to
>> the beginning of the drivers/watchdog/Kconfig file. This moves the
>> entry before the "menuconfig WATCHDOG" entry. They use the exact same
>> trick in drivers/misc/Kconfig file. The very first lines of
>> drivers/watchdog/Kconfig file will look something like this:
>
> Is the Kconfig even warranted?  I mean, if there is a shared resource
> and it needs locking, then just apply the locking.   Where is the value
> in adding another Kconfig?
>
The reason we are forced to do this is that all the it87 drivers are
usually modules. We need a global lock that is compiled into the
kernel if one or more of these drivers are selected. If none of them
are specified then the lock is not built into the kernel. The Kconfig
entry that I have put is not human selectable. When any IT87 driver is
selected it will select IT87_LOCK there by compiling the lock into the
kernel.

-- 
Regards
Nat Gurumoorthy AB6SJ
