Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47130 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932279AbbEWTve (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 23 May 2015 15:51:34 -0400
Message-ID: <5560DA3F.3070707@roeck-us.net>
Date: Sat, 23 May 2015 12:51:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Timur Tabi <timur@codeaurora.org>, Fu Wei <fu.wei@linaro.org>
CC: Arnd Bergmann <arnd@arndb.de>, Hanjun Guo <hanjun.guo@linaro.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	vgandhi@codeaurora.org, wim@iguana.be,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org>	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>	<555F4236.7040206@linaro.org>	<4095167.UOriXdSu53@wuerfel>	<556097D5.9050103@codeaurora.org> <CADyBb7svbV6QdhzCsa9DiBLfyNpAJHkgm73VSKCieJioPwWHsw@mail.gmail.com> <5560C85B.8040100@roeck-us.net> <5560C8D3.40708@codeaurora.org>
In-Reply-To: <5560C8D3.40708@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/23/2015 11:37 AM, Timur Tabi wrote:
> Guenter Roeck wrote:
>> I think it is quite unfortunate that the specification is not public.
>> We have heard many statements about what is in the spec or not.
>
> All you need to do is go to http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0029b/index.html, get a free ARM account, and download the spec.
>
That helps - thanks a lot!

Folks, please correct me if my understanding of the specification
is wrong.

1) Pretimeout

The document suggests that
	WS1 = WS0 * 2
is in fact correct. In essence, there is just one counter,
not two. This means that a separate pretimeout does not really
make sense, since in practice the timeout would always be
twice the pretimeout, and changing just one without affecting
the other is not really possible.

2) 64 bit WCV register

The specification is not clear on how to read this register.
It clearly states that it is comprised of two 32-bit registers,
but it does not specify if a single 64-bit read would be atomic,
or if it would be split into two separate 32-bit operations.
This leaves room for interpretation by the implementer, and
may result in bad values if the implementation changes the
counter from, say, 0x000010000 to 0x0000ffff while the value
is read.

My interpretation of this is that it would be safer to read two
32-bit values and ensure that the values are consistent
instead of relying on the assumption that a single 64-bit read
would be atomic.

3) ACPI vs. FDT

The specification does not say anything about ACPI or FDT support
except that it assumes that there are "System description data
structures such as ACPI or FDT". Given that, the driver should
support both.

4) ARM vs. ARM64

SBSA clearly states that any CPU supporting it shall be ARM v8
compliant (4.1.1, CPU architecture). Personally I think the
discussion around supporting the driver on ARM/ARM64 or ARM64
only is a bit pointless, especially since being able to build
it on ARM doesn't really hurt, even though there is currently
no HW supporting it.

Overall I must admit that I don't really understand why this is
such a contentious issue.

5) Revision support

While it is difficult to predict the future, it is common practice
in the industry to make future revisions of a standard (and chip)
as much backward compatible as possible, and to only add functionality.
As such, I don't see a reason to restrict support to revision 0
of the standard.

6) A note about driver messages

Implementation defined registers are just that, implementation
defined registers. I don't think it makes sense to display any
of those, not even for debugging purposes.

---

Again, please correct me if any of those statements is wrong.
When doing so, please reference the specification, to make sure
that we all know what we are talking about.

My hope is that we can use this as a starting point to converge
on a single driver.

Thanks,
Guenter

