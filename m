Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41225 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031220AbbKENrI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Nov 2015 08:47:08 -0500
Subject: Re: [Linaro-acpi] [PATCH v8 5/5] Watchdog: introduce ARM SBSA
 watchdog driver
To: Fu Wei <fu.wei@linaro.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>, Jon Masters <jcm@redhat.com>,
	Pratyush Anand <panand@redhat.com>,
	Will Deacon <will.deacon@arm.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Wei Fu <tekkamanninja@gmail.com>,
	Rob Herring <robherring2@gmail.com>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Dave Young <dyoung@redhat.com>
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
 <1445961999-9506-6-git-send-email-fu.wei@linaro.org>
 <CAOZdJXV8x8EMQEZhdFS+34iO+6P9S==k9bQjt=67iXt6K2oSCw@mail.gmail.com>
 <563AE588.1080009@roeck-us.net>
 <CADyBb7tTf0Jz0sgKecSn-LgMEUMdueTb5Uxq_e5t39byOsJQEQ@mail.gmail.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <563B5DD8.901@codeaurora.org>
Date: Thu, 5 Nov 2015 07:47:04 -0600
MIME-Version: 1.0
In-Reply-To: <CADyBb7tTf0Jz0sgKecSn-LgMEUMdueTb5Uxq_e5t39byOsJQEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fu Wei wrote:
> (1)It is not new.
>   pre-timeout concept has been used by two drivers before this driver.
> and this concept has been in kernel documentation.

It's "new" in that it's a new infrastructure.  The private API of two 
other drivers doesn't count.

> (1) if we don't, for this two stages timeout, we have to config them
> by one value.
> that means "the first stage timeout" have to be equal to "the second
> stage timeout",
> For example, if we need 60 second for  "the second stage timeout", 30
> or less for "the first stage timeout".
> then "the first stage timeout" have to be 60s too. I don't think it 's
> good idea.

Why do we care about two stages?  Don't have a pre-timeout, and just 
have one stage: the WS1 reset.  Ignore the WS0 interrupt, and program 
the timeout so that WS1 is the reset.

I'm not saying that pre-timeout is a terrible idea and we should never 
do it.  I'm saying that it's not an important feature, and we should 
only support it to the extent that the hardware provides the feature. 
We should definitely not make the driver more complicated and less safe.

If we agree that an SBSA watchdog allows for a pre-timeout at half-way 
through timeout, and that software can't change this, then we can use 
WS0 as the pre-timeout and applications just have to deal with that. 
The hardware is programmed to reset via WS1, and all we do in the 
interrupt handler is notify the application that a pre-timeout has 
occurred.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
