Return-path: <timur@codeaurora.org>
Message-ID: <55629B15.2060102@codeaurora.org>
Date: Sun, 24 May 2015 22:46:29 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Fu Wei <fu.wei@linaro.org>, Guenter Roeck <linux@roeck-us.net>
CC: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Wei Fu <tekkamanninja@gmail.com>, G Gregory
 <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
 Hanjun Guo <hanjun.guo@linaro.org>,
 Ashwin Chaugule <ashwin.chaugule@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org, wim@iguana.be,
 Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
 Jon Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org>	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>	<555DB4C4.5090606@roeck-us.net>	<555DD8EE.1060607@codeaurora.org>	<20150521152838.GB16668@roeck-us.net> <CADyBb7tH+oa_efFTA0V7YksNN+8L+4xGtWuXpxp91SO3e_f9Vg@mail.gmail.com>
In-Reply-To: <CADyBb7tH+oa_efFTA0V7YksNN+8L+4xGtWuXpxp91SO3e_f9Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Fu Wei wrote:
> Once the Linux kernel has KVM support and is in hyp mode. we
> may need to use arch_counter_get_cntpct.

arch_counter_get_cntpct() does not appear to be valid for ARM64:

http://lxr.free-electrons.com/source/arch/arm64/include/asm/arch_timer.h#L108

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
