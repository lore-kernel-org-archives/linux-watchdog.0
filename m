Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56590 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878AbbKBEXT (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 1 Nov 2015 23:23:19 -0500
Message-ID: <5636E531.5050907@redhat.com>
Date: Sun, 01 Nov 2015 23:23:13 -0500
From: Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
To: Timur Tabi <timur@codeaurora.org>, Fu Wei <fu.wei@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>
CC: Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Rafael Wysocki <rjw@rjwysocki.net>,
	Dave Young <dyoung@redhat.com>,
	Pratyush Anand <panand@redhat.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v8 1/5] Documentation: add sbsa-gwdt driver documentation
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org> <1445961999-9506-2-git-send-email-fu.wei@linaro.org> <20151027162257.GJ3091@leverpostej> <CADyBb7sAcT4bXrkNo2GKx1Tw5wOuf8JeMgCoiAw=owHqvYx6ug@mail.gmail.com> <CAOZdJXVan3xaYAS_+150nDO1ogWh+PtkQAZvwrHusJhY4R1a4A@mail.gmail.com> <CADyBb7sPqsoQdYBUpHY2HvZ+iT7ABa9NoCX7Jax1NKugYOy1zQ@mail.gmail.com> <5633BCA4.1050400@codeaurora.org> <20151030190514.GD30791@leverpostej> <CADyBb7sjZ-XcPkGqtD4Dq-V5CmXY1dSBf7RiC7VLunMBrdMvMw@mail.gmail.com> <5636E14B.8000305@codeaurora.org>
In-Reply-To: <5636E14B.8000305@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/01/2015 11:06 PM, Timur Tabi wrote:
> Fu Wei wrote:
>> In virtualization system, Linux kernel with KVM support as a
>> Hypervisor, and guest are using a one of SBSA watchdog.
>> WS0 is handled by guest OS, and WS1 will be handled by Hypervisor.
> 
> I don't see how that would work, because the host kernel cannot 
> reconfigure the behavior of WS1.
> 
> Besides, don't KVM guests use some kind of software and/or 
> paravirtualized watchdog?

Indeed, this is my expectation. IIRC the hardware watchdog initially
defined in SBSA was intended for bare metal use to have something people
could start implementing while we worked on the future (the language
around register frames relates to secure/non-secure ELs in my
recollection). For now, I expect an emulated watchdog for VMs, which
ideally would be a software implementation of the same SBSA watchdog.

Jon.

