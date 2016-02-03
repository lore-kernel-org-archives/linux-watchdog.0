Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36251 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964940AbcBCR7C (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Feb 2016 12:59:02 -0500
Subject: Re: [PATCH v10 4/5] Watchdog: introduce ARM SBSA watchdog driver
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
 <1454519923-25230-5-git-send-email-fu.wei@linaro.org>
 <56B23D61.2050001@codeaurora.org>
 <CADyBb7tteV7VF9oxMaq5NprVdS2UBKobupxoyfSp+jQwp5wmQA@mail.gmail.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <56B23FE1.2010207@codeaurora.org>
Date: Wed, 3 Feb 2016 11:58:57 -0600
MIME-Version: 1.0
In-Reply-To: <CADyBb7tteV7VF9oxMaq5NprVdS2UBKobupxoyfSp+jQwp5wmQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fu Wei wrote:
> I have posted  GTDT support separately :https://lkml.org/lkml/2016/2/1/660
>
> devicetree driver and GTDT driver both export sbsa gwdt info to
> "platform resource".
>
> this driver get hardware info from platform resource.

I must be missing something.  How does the driver probe?  It only has an 
entry for device tree:

+		.of_match_table = sbsa_gwdt_of_match,

Doesn't there need to be an ACPI match table to probe on an ACPI system?
