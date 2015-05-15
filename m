Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <8715806.mTJfA5WAcP@wuerfel>
References: <=fu.wei@linaro.org>
	<1431688090-2145-1-git-send-email-fu.wei@linaro.org>
	<1431688090-2145-2-git-send-email-fu.wei@linaro.org>
	<8715806.mTJfA5WAcP@wuerfel>
Date: Fri, 15 May 2015 22:14:36 +0800
Message-ID: <CADyBb7u08p4PS9wfRPN7b8WpH+FtHNtG=ZwiMAGBZM20__OGUA@mail.gmail.com>
Subject: Re: [PATCH 1/6] Documentation: add sbsa-gwdt.txt documentation
From: Fu Wei <fu.wei@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>, Guenter Roeck <linux@roeck-us.net>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Arnd,

Great thanks, np, will do so

On 15 May 2015 at 22:06, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 15 May 2015 19:08:05 fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> The sbsa-gwdt.txt documentation in devicetree/bindings/watchdog is for
>> introducing SBSA(Server Base System Architecture) Generic Watchdog
>> device node info into FDT
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>
> Looks good, just one minor comment:
>
>> +Optional properties
>> +- timeout-sec : Watchdog pre-timeout and timeout values (in seconds).
>> +     The first is timeout values, then pre-timeout.
>
> Please update Documentation/watchdog/watchdog-kernel-api.txt as well, to
> mention the second number in the timeout-sec property.
>
>         Arnd
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



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
