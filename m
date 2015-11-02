Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50603 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbbKBEGk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 1 Nov 2015 23:06:40 -0500
Subject: Re: [PATCH v8 1/5] Documentation: add sbsa-gwdt driver documentation
To: Fu Wei <fu.wei@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Rafael Wysocki <rjw@rjwysocki.net>,
	Dave Young <dyoung@redhat.com>,
	Pratyush Anand <panand@redhat.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Rob Herring <robherring2@gmail.com>
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
 <1445961999-9506-2-git-send-email-fu.wei@linaro.org>
 <20151027162257.GJ3091@leverpostej>
 <CADyBb7sAcT4bXrkNo2GKx1Tw5wOuf8JeMgCoiAw=owHqvYx6ug@mail.gmail.com>
 <CAOZdJXVan3xaYAS_+150nDO1ogWh+PtkQAZvwrHusJhY4R1a4A@mail.gmail.com>
 <CADyBb7sPqsoQdYBUpHY2HvZ+iT7ABa9NoCX7Jax1NKugYOy1zQ@mail.gmail.com>
 <5633BCA4.1050400@codeaurora.org> <20151030190514.GD30791@leverpostej>
 <CADyBb7sjZ-XcPkGqtD4Dq-V5CmXY1dSBf7RiC7VLunMBrdMvMw@mail.gmail.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <5636E14B.8000305@codeaurora.org>
Date: Sun, 1 Nov 2015 22:06:35 -0600
MIME-Version: 1.0
In-Reply-To: <CADyBb7sjZ-XcPkGqtD4Dq-V5CmXY1dSBf7RiC7VLunMBrdMvMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fu Wei wrote:
> In virtualization system, Linux kernel with KVM support as a
> Hypervisor, and guest are using a one of SBSA watchdog.
> WS0 is handled by guest OS, and WS1 will be handled by Hypervisor.

I don't see how that would work, because the host kernel cannot 
reconfigure the behavior of WS1.

Besides, don't KVM guests use some kind of software and/or 
paravirtualized watchdog?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
