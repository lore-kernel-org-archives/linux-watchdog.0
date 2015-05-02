Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38918 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbbEBNQQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 2 May 2015 09:16:16 -0400
Message-ID: <5544CE15.9050800@codeaurora.org>
Date: Sat, 02 May 2015 08:16:05 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
	linaro-acpi@lists.linaro.org
CC: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Vipul Gandhi <vgandhi@codeaurora.org>
Subject: Re: [Linaro-acpi] [PATCH] watchdog: introduce the ARM64 SBSA
 watchdog driver
References: <1430336034-5275-1-git-send-email-timur@codeaurora.org> <20150501174953.GB7712@roeck-us.net> <5543C921.9050800@codeaurora.org> <28676294.hhciQCjd9F@wuerfel> <5543DA53.8070702@codeaurora.org> <55440CBD.6000504@roeck-us.net>
In-Reply-To: <55440CBD.6000504@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Guenter Roeck wrote:
> Even if you (and/or others) may personally believe that ACPI _is_ the
> center of the universe, please be open to the possibility that others
> may have a different opinion and/or different requirements. We should not
> have to completely rewrite the driver to add devicetree support later on.

There won't be any need to rewrite the driver to add device tree 
support.  All we need to do is add the device tree probe function.

> Note we still have to figure out how to instantiate the device based on
> the acpi data. I have no idea how that should be done, but it seems
> odd if it is really supposed to be done as you have implemented it.
> Maybe that is the case, but if so I would like to get a confirmation
> from an acpi maintainer.

Me too.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
