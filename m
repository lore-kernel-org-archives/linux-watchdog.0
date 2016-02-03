Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38484 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965186AbcBCSJD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Feb 2016 13:09:03 -0500
Subject: Re: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
To: Fu Wei <fu.wei@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?Q?Pawe=c5=82_Moll?= <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
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
	Leo Duran <leo.duran@amd.com>, sudeep.holla@arm.com
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
 <56B23883.7000501@codeaurora.org>
 <CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
 <56B23E99.1030604@codeaurora.org>
 <CADyBb7s4opxfPFuX=1-qEE6uhsaMXgofAJPbHUQHrng2AUwqNA@mail.gmail.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <56B2423B.1020109@codeaurora.org>
Date: Wed, 3 Feb 2016 12:08:59 -0600
MIME-Version: 1.0
In-Reply-To: <CADyBb7s4opxfPFuX=1-qEE6uhsaMXgofAJPbHUQHrng2AUwqNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fu Wei wrote:
> Actually I am taking your suggestion to avoid touching WCV in
> interrupt routine.
> So even we have pre-timeout support , it is useless for this
> panic-on-half-timeout feature,
> because pre-timeout  == timeout / 2 (always).
>
> So maybe I misunderstand your suggestion,
> could you let me know : why we want pre-timeout here?

Maybe I'm confused.

For pre-timeout, I think the SBSA watchdog driver should support only 
half-timeout.  That is, the user cannot configure the length of the 
pre-timeout with this driver.  He can only enable it, and it is 
automatically set to 1/2 timeout.

So when pre-timeout occurs, the interrupt handler calls panic() or 
whatever it's supposed to do.

So "pre-timeout  == timeout / 2 (always)" is exactly what we want.
