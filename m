Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <557B470B.9030908@codeaurora.org>
References: <=fu.wei@linaro.org>
	<1433958452-23721-1-git-send-email-fu.wei@linaro.org>
	<1433958452-23721-4-git-send-email-fu.wei@linaro.org>
	<557B470B.9030908@codeaurora.org>
Date: Sun, 14 Jun 2015 18:05:05 +0800
Message-ID: <CADyBb7seDgmQYxjsxCo_thPr_w847oy7d0AEiL8w9T_ZCF9+BQ@mail.gmail.com>
Subject: Re: [PATCH non-pretimeout 3/7] ARM64: add SBSA Generic Watchdog
 device node in amd-seattle-soc.dtsi
From: Fu Wei <fu.wei@linaro.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
	Vipul Gandhi <vgandhi@codeaurora.org>, Wim Van Sebroeck <wim@iguana.be>, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, rjw@rjwysocki.net
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On 13 June 2015 at 04:54, Timur Tabi <timur@codeaurora.org> wrote:
> On 06/10/2015 12:47 PM, fu.wei@linaro.org wrote:
>>
>> +                       reg = <0x0 0xe0bb0000 0 0x10000>,
>> +                               <0x0 0xe0bc0000 0 0x10000>;
>
>
> I think the sizes are wrong.  They should be 0x1000 instead of 0x10000.

This has been proved by test, it works well on Seattle
Foundation model has same value. So I don't think it is wrong

otherwise someone has the data sheet of Seattle B0, and it shows that is wrong.


>
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
