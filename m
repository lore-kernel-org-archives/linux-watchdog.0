Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44067 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932953AbbENUpK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 May 2015 16:45:10 -0400
Date: Thu, 14 May 2015 13:45:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Timur Tabi <timur@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-watchdog@vger.kernel.org,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Fu Wei <fu.wei@linaro.org>, Al Stone <al.stone@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Graeme Gregory <graeme.gregory@linaro.org>,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] [v2] watchdog: introduce the ARM64 SBSA watchdog driver
Message-ID: <20150514204505.GA10374@roeck-us.net>
References: <1431622353-11196-1-git-send-email-timur@codeaurora.org>
 <3074350.inBBIzlShL@wuerfel>
 <5555027B.6010701@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5555027B.6010701@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, May 14, 2015 at 03:15:55PM -0500, Timur Tabi wrote:
> On 05/14/2015 03:03 PM, Arnd Bergmann wrote:
> >>>+       writel(cpu_to_le32(wor), &data->control->wor);
> >Why the double endianess swap? Are the registers defined to be CPU-endian?
> >
> >You probably mean le32_to_cpu() here, not the other way round, although
> >the effect is the same.
> 
> Maybe I'd doing the whole __le32 thing wrong, but I think cpu_to_le32(wor)
> is correct.  'wor' is a normal integer, so it's in "cpu" format.  I want to
> convert it to le32 format so that I write an le32 value to memory.
> Therefore, cpu_to_le32().  Most calls to writel() use cpu_to_le32():
> 
What other drivers do is completely irrelevant. The key question is what
_this_ hardware does, and you should know that.

It concerns me that you point to other drivers as argument for using the
endianness conversion your code. That raises the question if you really
understand the hardware. Is the register known to be a little endian register,
even on a big endian machine, or is it in host byte order ? You don't really
answer that question.

Guenter
