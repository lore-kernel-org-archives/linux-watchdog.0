Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35297 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbcFRDjL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 17 Jun 2016 23:39:11 -0400
Date: Fri, 17 Jun 2016 23:39:04 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Guenter Roeck <linux@roeck-us.net>,
	Alexandre Courbot <gnurou@gmail.com>, sasha.levin@oracle.com,
	xiaolong.ye@intel.com
Subject: Re: [PATCH v5 2/4] gpio: Allow PC/104 devices on X86_64
Message-ID: <20160618033812.GA20596@sophia>
References: <cover.1464380034.git.vilhelm.gray@gmail.com>
 <61880bededb77bbc3ea3422e48ce717d2a2ff489.1464380034.git.vilhelm.gray@gmail.com>
 <CACRpkdaOzZ1DvEUKtomBU=GH1kYfjKJjUfM-=45PhdzZA=dPgg@mail.gmail.com>
 <20160531112251.GA5674@sophia>
 <20160531152541.GB13304@kroah.com>
 <057d8c0b-074c-609a-35da-5a01f07b6d31@leemhuis.info>
 <20160618023607.GA7390@kroah.com>
 <20160618024959.GA4702@sophia>
 <20160618031810.GA29160@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160618031810.GA29160@kroah.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jun 17, 2016 at 08:18:10PM -0700, Greg KH wrote:
>On Fri, Jun 17, 2016 at 10:49:59PM -0400, William Breathitt Gray wrote:
>> The PC/104 drivers were changed to utilize the ISA bus driver as part of
>> the original patchset which attempted to decouple the X86_32 dependency
>> from the ISA Kconfig option; these drivers were updated with the
>> intention of building on X86_64 in addition to X86_32.
>> 
>> However, the respective patches were merged without the decoupling
>> changes (since decoupling was the wrong approach), resulting in an
>> unintentional regression: the PC/104 drivers are now restricted to
>> X86_32 due to the ISA Kconfig option dependency, while they were capable
>> of building for X86_64 in previous kernel versions.
>> 
>> This patchset should fix this regression by introducing the ISA_BUS_API
>> Kconfig option, and the respective Kconfig dependency changes for the
>> drivers, in order to allow them to build for both X86_64 and X86_32 as
>> originally capable.
>
>Ah, ok, that makes more sense, thanks.  I'll go queue these up now.
>
>greg k-h

Greg K-H,

Please also consider picking up the following two patches which fix bugs
discovered during the ISA bus driver utilization conversion:

  1. https://patchwork.kernel.org/patch/9046831/
  2. https://patchwork.kernel.org/patch/9074641/

The second patch in particular fixes a kernel BUG which prevents some
drivers that call isa_register_driver from being built-in. This was
first reported by Sasha Levin (https://lkml.org/lkml/2016/5/11/719), and
the patch was later tested by Ye Xiaolong
(https://lkml.org/lkml/2016/5/31/164).

Thanks,

William Breathitt Gray
