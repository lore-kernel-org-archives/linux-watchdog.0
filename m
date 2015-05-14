Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40726 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422966AbbENXlP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 May 2015 19:41:15 -0400
Message-ID: <55553291.3050009@roeck-us.net>
Date: Thu, 14 May 2015 16:41:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Timur Tabi <timur@codeaurora.org>
CC: Arnd Bergmann <arnd@arndb.de>, linux-watchdog@vger.kernel.org,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Fu Wei <fu.wei@linaro.org>, Al Stone <al.stone@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Graeme Gregory <graeme.gregory@linaro.org>,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] [v2] watchdog: introduce the ARM64 SBSA watchdog driver
References: <1431622353-11196-1-git-send-email-timur@codeaurora.org> <3074350.inBBIzlShL@wuerfel> <5555027B.6010701@codeaurora.org> <20150514204505.GA10374@roeck-us.net> <55550D8E.6000408@codeaurora.org>
In-Reply-To: <55550D8E.6000408@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/14/2015 02:03 PM, Timur Tabi wrote:
> On 05/14/2015 03:45 PM, Guenter Roeck wrote:
>> It concerns me that you point to other drivers as argument for using the
>> endianness conversion your code. That raises the question if you really
>> understand the hardware.
>
> The only information I have on how the hardware works is the SBSA document and the internal documentation for our ARM64 server chip.
>
>  > Is the register known to be a little endian register,
>> even on a big endian machine, or is it in host byte order ? You don't really
>> answer that question.
>
> The ARM SBSA says in section 4.1.1:
>
>      * CPUs shall implement little-endian support.
>
That doesn't really say anything. It neither says that the CPU must _run_
in little endian mode, nor does it say anything about its register byte order.

> That's the only reference to endianness in the document.  I don't know if that means that the device registers must also be little-endian. Does Linux even support running ARM64 in big-endian mode?
>

Interesting question. You should be able to answer it yourself.
Hint: Look in arch/arm64/Kconfig.

> So maybe it's safe to say that everything must be little endian?  If so, do I still need the __le32 in the structs, and should I still use cpu_to_le32()?
>

We still don't know if the registers are in host byte order or in little endian
order. If registers are in host byte order, there is no need for a conversion.

Guenter

