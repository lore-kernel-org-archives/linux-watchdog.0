Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62988 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab2DWMVV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Apr 2012 08:21:21 -0400
Received: by wgbdr13 with SMTP id dr13so11800381wgb.1
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Apr 2012 05:21:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F9547E3.4000709@arm.com>
References: <18a4584c24041ceb8a1972dd5ee70cf7c59fed21.1334932839.git.viresh.kumar@st.com>
	<7dbd64f72527cf92af0ec38f45275d71207d5ec5.1335008301.git.viresh.kumar@st.com>
	<4F9514AA.10403@arm.com>
	<CAOh2x=kroSi8MZBhYVOhrDm08q1B9LS_9P7NPAfHC01-MHaOCQ@mail.gmail.com>
	<4F9547E3.4000709@arm.com>
Date: Mon, 23 Apr 2012 17:51:20 +0530
Message-ID: <CAOh2x==ADdGi5gdsn0naVtU_g2cq6gBBxxz11LOVfYiwyCA-Ew@mail.gmail.com>
Subject: Re: [PATCH V2] watchdog: mpcore: Add DT probing support for ARM
 mpcore watchdog
From: viresh kumar <viresh.linux@gmail.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>
Cc: "wim@iguana.be" <wim@iguana.be>,
	"spear-devel@list.st.com" <spear-devel@list.st.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Viresh Kumar <viresh.kumar@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 4/23/12, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 23/04/12 12:35, viresh kumar wrote:
>> - subtract 0x20 from base address for DT case
>
> That's a possibility.
>
>> - something else.
>
> Given that no in-tree platform seem to be using this watchdog (at least
> a quick grep didn't reveal anything), I'd be inclined to simply change
> the offset in smp_twd.h and let them break.

I believe atlest ST Ericsson's Ux500 series is using it, Linus??

Obviously the best solution is to fix these offsets and pass watchdog
base address from DT or machine/board files.

I will see what i can do best.

--
viresh
