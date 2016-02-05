Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:54020 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752851AbcBENDD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Feb 2016 08:03:03 -0500
Date: Fri, 5 Feb 2016 14:02:59 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Fu Wei <fu.wei@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Timur Tabi <timur@codeaurora.org>,
	Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?B?UGF3ZcWC?= Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@codeaurora.org>,
	Christopher Covington <cov@codeaurora.org>,
	Dave Young <dyoung@redhat.com>,
	Pratyush Anand <panand@redhat.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Leo Duran <leo.duran@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half
 timeout panic support
Message-ID: <20160205140259.72a33699@free-electrons.com>
In-Reply-To: <CADyBb7unAHEOMfruWS82RkHK6uwPAWCxUx9jqzSkiHU4LHDSeA@mail.gmail.com>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
	<1454519923-25230-6-git-send-email-fu.wei@linaro.org>
	<56B23883.7000501@codeaurora.org>
	<CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
	<56B23E99.1030604@codeaurora.org>
	<CADyBb7s4opxfPFuX=1-qEE6uhsaMXgofAJPbHUQHrng2AUwqNA@mail.gmail.com>
	<56B2423B.1020109@codeaurora.org>
	<CADyBb7uULCn97ea19zH8dB4QX1QA8=AXL94d6gXgFxXM8haBNA@mail.gmail.com>
	<56B24642.8090105@codeaurora.org>
	<CADyBb7s_QeU=pYqN9G+5WMtx-L+=QC6uZR6N6ZWPOixnkHzPjw@mail.gmail.com>
	<56B24AB5.3070001@codeaurora.org>
	<CADyBb7usPpY=YLjecXce63zY5e1tniPLmNsVY=8CJHJsCqBgQw@mail.gmail.com>
	<56B2DEE4.7060901@roeck-us.net>
	<CADyBb7unAHEOMfruWS82RkHK6uwPAWCxUx9jqzSkiHU4LHDSeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

On Fri, 5 Feb 2016 17:51:52 +0800, Fu Wei wrote:

> OK, my thought is
> 
> if panic is enabled :
> |--------WOR-------WS0--------WOR-------WS1
> |------timeout------(panic)------timeout-----reset

I'm quite certainly missing something completely obvious here, but how
can you get the WS1 interrupt *after* raising a panic? Aren't all
interrupts disabled and the system fully halted once you get a panic(),
especially when raised from an interrupt handler? If that's the case,
how can the system continue to do things, such as receiving the WS1
interrupt and resetting ?

Again, I'm probably missing something obvious, but I'm interested to
understand the reasoning here.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
