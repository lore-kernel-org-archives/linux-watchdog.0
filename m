Return-path: <timur@codeaurora.org>
Message-ID: <5560D32D.60704@codeaurora.org>
Date: Sat, 23 May 2015 14:21:17 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Fu Wei <fu.wei@linaro.org>
CC: Arnd Bergmann <arnd@arndb.de>, Hanjun Guo
 <hanjun.guo@linaro.org>,
 Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Wei Fu <tekkamanninja@gmail.com>, G Gregory
 <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
 Ashwin Chaugule <ashwin.chaugule@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, vgandhi@codeaurora.org,
 wim@iguana.be, Jon Masters <jcm@redhat.com>,
 Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
 Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org>	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>	<555F4236.7040206@linaro.org>	<4095167.UOriXdSu53@wuerfel>	<556097D5.9050103@codeaurora.org>	<CADyBb7svbV6QdhzCsa9DiBLfyNpAJHkgm73VSKCieJioPwWHsw@mail.gmail.com>	<5560C984.10108@codeaurora.org> <CADyBb7u0ixabfJMqS0yFcYjTaOjz3NS+W4id9v00KyBnP08OpA@mail.gmail.com>
In-Reply-To: <CADyBb7u0ixabfJMqS0yFcYjTaOjz3NS+W4id9v00KyBnP08OpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Fu Wei wrote:

>> Because there's no market for it.  I'm not talking about what's
>> theoretically possible.  I'm only talking about what makes sense and what
>> will actually happen.  And I'm quite certain that we will never see an
>> actual 32-bit ARM SOC with an SBSA watchdog device in it.
>
> Why are you quite certain? any info you can kindly share here?

I used to work for a company called Calxeda that tried to sell a 32-bit 
ARM Server SOC.  Calxeda went out of business because no one would buy 
it, and that was two years ago.

>> So can we PLEASE stop talking about 32-bit ARM support?
>
> why? we are just trying to figure out:
> Do we need to add ARM in "depends on" for SBSA watchdog driver?
>
> If some one suggests this, we need to figure out.

We do not need to add "depends on ARM" in the Kconfig for the SBSA 
watchdog driver.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
