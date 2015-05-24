Return-path: <timur@codeaurora.org>
Message-ID: <5561E8F8.9030507@codeaurora.org>
Date: Sun, 24 May 2015 10:06:32 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, Fu Wei <fu.wei@linaro.org>
CC: Arnd Bergmann <arnd@arndb.de>, Hanjun Guo
 <hanjun.guo@linaro.org>,
 Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Wei Fu <tekkamanninja@gmail.com>, G Gregory
 <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
 Ashwin Chaugule <ashwin.chaugule@linaro.org>, vgandhi@codeaurora.org,
 wim@iguana.be, Jon Masters <jcm@redhat.com>,
 Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
 Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org>	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>	<555F4236.7040206@linaro.org>	<4095167.UOriXdSu53@wuerfel>	<556097D5.9050103@codeaurora.org>	<CADyBb7svbV6QdhzCsa9DiBLfyNpAJHkgm73VSKCieJioPwWHsw@mail.gmail.com>	<5560C85B.8040100@roeck-us.net>	<5560C8D3.40708@codeaurora.org>	<5560DA3F.3070707@roeck-us.net> <CADyBb7sW8GTJmRR2ysUAYtZ=mkSCFZBzXuor=puLck0Q983NMw@mail.gmail.com> <5561DAF3.8020805@roeck-us.net>
In-Reply-To: <5561DAF3.8020805@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Guenter Roeck wrote:
>
> Maybe you and/or Timur can test this on the real systems you
> have access to. It should be quite straightforward to test -
> have the interrupt handler only print a message, program some
> values into the watchdog, and see when WS0 and WS1 occur.

I'll try, but on my system, WS1 is currently not implemented fully.  Let 
me investigate and get back to you.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
