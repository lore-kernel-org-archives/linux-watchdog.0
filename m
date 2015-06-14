Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58308 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbbFNN6D (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 14 Jun 2015 09:58:03 -0400
Message-ID: <557D8862.8020805@roeck-us.net>
Date: Sun, 14 Jun 2015 06:57:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Fu Wei <fu.wei@linaro.org>, Timur Tabi <timur@codeaurora.org>
CC: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, rjw@rjwysocki.net
Subject: Re: [PATCH non-pretimeout 3/7] ARM64: add SBSA Generic Watchdog device
 node in amd-seattle-soc.dtsi
References: <=fu.wei@linaro.org>	<1433958452-23721-1-git-send-email-fu.wei@linaro.org>	<1433958452-23721-4-git-send-email-fu.wei@linaro.org>	<557B470B.9030908@codeaurora.org> <CADyBb7seDgmQYxjsxCo_thPr_w847oy7d0AEiL8w9T_ZCF9+BQ@mail.gmail.com>
In-Reply-To: <CADyBb7seDgmQYxjsxCo_thPr_w847oy7d0AEiL8w9T_ZCF9+BQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/14/2015 03:05 AM, Fu Wei wrote:
> On 13 June 2015 at 04:54, Timur Tabi <timur@codeaurora.org> wrote:
>> On 06/10/2015 12:47 PM, fu.wei@linaro.org wrote:
>>>
>>> +                       reg = <0x0 0xe0bb0000 0 0x10000>,
>>> +                               <0x0 0xe0bc0000 0 0x10000>;
>>
>>
>> I think the sizes are wrong.  They should be 0x1000 instead of 0x10000.
>
> This has been proved by test, it works well on Seattle
> Foundation model has same value. So I don't think it is wrong
>
> otherwise someone has the data sheet of Seattle B0, and it shows that is wrong.
>

If only 0x1000 is used, why would you have to reserve 0x10000 ?
You never access any higher addresses, so no matter what the datasheet
says, 0x1000 should be sufficient. What matters is what the driver uses.

Guenter


