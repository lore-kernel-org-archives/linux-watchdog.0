Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38247 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab2DWQB0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Apr 2012 12:01:26 -0400
Received: by wgbdr13 with SMTP id dr13so12004464wgb.1
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Apr 2012 09:01:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F957A0C.7060607@arm.com>
References: <18a4584c24041ceb8a1972dd5ee70cf7c59fed21.1334932839.git.viresh.kumar@st.com>
	<7dbd64f72527cf92af0ec38f45275d71207d5ec5.1335008301.git.viresh.kumar@st.com>
	<4F9514AA.10403@arm.com>
	<CAOh2x=kroSi8MZBhYVOhrDm08q1B9LS_9P7NPAfHC01-MHaOCQ@mail.gmail.com>
	<4F9547E3.4000709@arm.com>
	<CAOh2x=kQvjP5SYfJsTXkZyNe3UsS-=pXUBKoQ=SsMUNcPGjzuA@mail.gmail.com>
	<4F9573B8.9050607@arm.com>
	<CAOh2x=n5Zm9MR5twDY-CUA-ppE9ADXrg25XCT5RKM++v6=tcpA@mail.gmail.com>
	<4F957A0C.7060607@arm.com>
Date: Mon, 23 Apr 2012 21:31:25 +0530
Message-ID: <CAOh2x=kyJ3tG3go0TQ2LXLOKDf0m9=uz1=KC7asMS0FSxtx9uA@mail.gmail.com>
Subject: Re: [PATCH V2] watchdog: mpcore: Add DT probing support for ARM
 mpcore watchdog
From: viresh kumar <viresh.linux@gmail.com>
To: Marc Zyngier <marc.zyngier@arm.com>
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
> The TWD watchdog uses a per-cpu interrupt (usually interrupt #30), and
> the GIC configuration should flag it as such. With this setup,
> request_irq() should fail, and the right API is request_percpu_irq(),
> together with enable_percpu_irq()/disable_percpu_irq().

request_irq() doesn't fail for me even if i pass it.

> So how it works in your environment is a bit puzzling. Unless you're not
> using GIC?

We use GIC and are running SMP. But we don't use wdt interrupt :)
We only test it for system reset/reboot.

I don't have a patch for this. Can you please add that?

--
Viresh
