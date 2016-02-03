Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39259 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965222AbcBCSMh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Feb 2016 13:12:37 -0500
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
 <56B23FE1.2010207@codeaurora.org>
 <CADyBb7vRTz9NxEmeGvxDooUUUXPPFFcNsjUADHcmSKHS56ZYjA@mail.gmail.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <56B2430F.4070708@codeaurora.org>
Date: Wed, 3 Feb 2016 12:12:31 -0600
MIME-Version: 1.0
In-Reply-To: <CADyBb7vRTz9NxEmeGvxDooUUUXPPFFcNsjUADHcmSKHS56ZYjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fu Wei wrote:
> static const struct platform_device_id sbsa_gwdt_pdev_match[] = {
>   { .name = "sbsa-gwdt", },
>   {},
> };
> MODULE_DEVICE_TABLE(platform, sbsa_gwdt_pdev_match);

Ok, thanks.
