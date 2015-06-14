Return-path: <timur@codeaurora.org>
Message-ID: <557D7EEF.7010501@codeaurora.org>
Date: Sun, 14 Jun 2015 08:17:35 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Fu Wei <fu.wei@linaro.org>
CC: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Wei Fu <tekkamanninja@gmail.com>, G Gregory
 <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
 Hanjun Guo <hanjun.guo@linaro.org>,
 Ashwin Chaugule <ashwin.chaugule@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
 Vipul Gandhi <vgandhi@codeaurora.org>, Wim Van Sebroeck
 <wim@iguana.be>, Jon Masters <jcm@redhat.com>,
 Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
 Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, rjw@rjwysocki.net
Subject: Re: [PATCH non-pretimeout 3/7] ARM64: add SBSA Generic
 Watchdog device node in amd-seattle-soc.dtsi
References: <=fu.wei@linaro.org>	<1433958452-23721-1-git-send-email-fu.wei@linaro.org>	<1433958452-23721-4-git-send-email-fu.wei@linaro.org>	<557B470B.9030908@codeaurora.org> <CADyBb7seDgmQYxjsxCo_thPr_w847oy7d0AEiL8w9T_ZCF9+BQ@mail.gmail.com>
In-Reply-To: <CADyBb7seDgmQYxjsxCo_thPr_w847oy7d0AEiL8w9T_ZCF9+BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Fu Wei wrote:
>> >I think the sizes are wrong.  They should be 0x1000 instead of 0x10000.
> This has been proved by test, it works well on Seattle
> Foundation model has same value. So I don't think it is wrong
>
> otherwise someone has the data sheet of Seattle B0, and it shows that is wrong.

The registers block is only 0x1000 bytes long.  So you're wasting 63KB 
of virtual address space for each block.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
