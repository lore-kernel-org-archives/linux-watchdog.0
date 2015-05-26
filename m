Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60182 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbbEZUtZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 May 2015 16:49:25 -0400
Message-ID: <5564DC52.6010204@codeaurora.org>
Date: Tue, 26 May 2015 15:49:22 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Al Stone <al.stone@linaro.org>, linux-watchdog@vger.kernel.org,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Fu Wei <fu.wei@linaro.org>, Wim Van Sebroeck <wim@iguana.be>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Graeme Gregory <graeme.gregory@linaro.org>,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] [v4] watchdog: introduce the ARM64 SBSA watchdog driver
References: <1432335137-1023-1-git-send-email-timur@codeaurora.org> <5564A92F.4090403@linaro.org> <5564B43E.6060504@codeaurora.org> <5564D9D6.9050309@linaro.org>
In-Reply-To: <5564D9D6.9050309@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/26/2015 03:38 PM, Al Stone wrote:
> Ah.  I have to think on that a bit; it sounds reasonable.  I guess I was
> wondering about how the DT usage would work vs the ACPI usage and trying
> to make them very similar in my head.  That may just give me a headache,
> however.

I haven't tested the code myself, but the driver uses named properties 
to get the base address for the device, so as long as the device tree 
has those property names, it should work automatically.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
