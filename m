Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55434 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756941AbbFCSxd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Jun 2015 14:53:33 -0400
Message-ID: <556F4D29.1080001@codeaurora.org>
Date: Wed, 03 Jun 2015 13:53:29 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
	linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, tekkamanninja@gmail.com,
	graeme.gregory@linaro.org, al.stone@linaro.org,
	hanjun.guo@linaro.org, ashwin.chaugule@linaro.org, arnd@arndb.de,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com,
	catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net
Subject: Re: [PATCH v4 5/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org> <1433217907-928-1-git-send-email-fu.wei@linaro.org> <1433217907-928-6-git-send-email-fu.wei@linaro.org> <556F4489.6030206@codeaurora.org> <20150603182503.GD6460@roeck-us.net>
In-Reply-To: <20150603182503.GD6460@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/03/2015 01:25 PM, Guenter Roeck wrote:
> In general the idea here would be to use a crashdump kernel, which,
> when loaded, would reset the watchdog before it fires. This kernel
> would then write a core dump to a specified location.

What is the mechanism for resetting the watchdog?  The only code that 
knows about the hardware registers is this driver.  Does the crashdump 
kernel call the watchdog stop function?

> If arm64 doesn't support a crashdump kernel, it might still be possible
> to log the backtrace somewhere (eg in nvram using pstore if that is
> supported via acpi or efi).

I think it's expected that the firmware support a crash dump mechanism 
of some kind.  But if we're talking about firmware support, then why 
bother with the panic() in the first place?

> Is there reason to believe that this all won't work on arm64 ?

No, but I'm still trying to figure out why pre-timeout is valuable.  If 
we don't disable WS1, then we risk having the hardware reset before we 
can take advantage of what the panic() offers.  In which case, what's 
the point of pre-timeout?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
