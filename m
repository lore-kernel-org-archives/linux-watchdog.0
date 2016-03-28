Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48886 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677AbcC1OLk (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Mar 2016 10:11:40 -0400
Date: Mon, 28 Mar 2016 19:41:36 +0530
From: Pratyush Anand <panand@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
	Fu Wei <fu.wei@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	=?utf-8?B?UGF3ZcWC?= Moll <pawel.moll@arm.com>,
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
	Richard Ruigrok <rruigrok@codeaurora.org>,
	"Abdulhamid, Harb" <harba@codeaurora.org>,
	Christopher Covington <cov@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>,
	Dave Young <dyoung@redhat.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v14 3/4] ARM64: add SBSA Generic Watchdog device node in
 amd-seattle-soc.dtsi
Message-ID: <20160328141136.GA13855@dhcppc0.redhat.com>
References: <1456735610-22012-1-git-send-email-fu.wei@linaro.org>
 <1456735610-22012-4-git-send-email-fu.wei@linaro.org>
 <CADyBb7shY-A-DTKEvNQS71SUtNmE6tkURfWDEb-_9eB-4htGWA@mail.gmail.com>
 <56F935AC.3020009@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56F935AC.3020009@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 28/03/2016:06:46:20 AM, Guenter Roeck wrote:
> On 03/28/2016 06:12 AM, Fu Wei wrote:
> >Hi Wim, Guenter:
> >
> >Great thanks for reviewing and applying this patchset :-)
> >Now I can see almost all the patches of this patchset have been merged
> >into the master branch of mainline kernel.
> >But only this one is still out of any branch or repo. It seems that
> >it's applied on linux-watchdog for a while, then disappeared.
> >
> >
> >So any thing I can do for this patch? Do I need to resubmit it?
> >Maybe I miss it in some repo? Could you help me ?
> >Great thanks ! :-)
> >
> 
> If I recall correctly, it was supposed to go in through some other tree (arm-soc ?)

Yes, it should have gone through arm-soc tree. But, it seems it got missed.  The
other dt patch for foundation-v8 is there in v4.6 pull request
[https://lkml.org/lkml/2016/3/20/244].

~Pratyush
