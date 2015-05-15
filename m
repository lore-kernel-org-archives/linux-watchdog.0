Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57356 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934130AbbEOMOM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 May 2015 08:14:12 -0400
Message-ID: <5555E310.7040009@codeaurora.org>
Date: Fri, 15 May 2015 07:14:08 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Fu Wei <fu.wei@linaro.org>, Al Stone <al.stone@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Graeme Gregory <graeme.gregory@linaro.org>,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] [v2] watchdog: introduce the ARM64 SBSA watchdog driver
References: <1431622353-11196-1-git-send-email-timur@codeaurora.org> <55553291.3050009@roeck-us.net> <5555347D.7050106@codeaurora.org> <5740260.iFKebBHUuJ@wuerfel>
In-Reply-To: <5740260.iFKebBHUuJ@wuerfel>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Arnd Bergmann wrote:
> Then please remove the double-swap. If the device works like any other
> device in the system, then the byteswap that is implied by readl/writel
> will do the right thing, and swapping twice will break big-endian
> kernels.

Should I still keep the __le32 in the structs?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
