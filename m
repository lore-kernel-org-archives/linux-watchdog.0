Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:56469 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752306Ab2DXKg4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Apr 2012 06:36:56 -0400
Message-ID: <4F9681D4.9010904@st.com>
Date: Tue, 24 Apr 2012 16:05:00 +0530
From: Viresh Kumar <viresh.kumar@st.com>
MIME-Version: 1.0
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: "wim@iguana.be" <wim@iguana.be>,
	spear-devel <spear-devel@list.st.com>,
	"viresh.linux@gmail.com" <viresh.linux@gmail.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Pawel Moll <Pawel.Moll@arm.com>
Subject: Re: [PATCH V3 2/2] watchdog: mpcore: Add DT probing support for ARM
 mpcore watchdog
References: <31b0b89e21e6a234cb904761a1d0e5106405da82.1335246446.git.viresh.kumar@st.com> <27dea103ccf6da5b7376c837d9a95dc7a9ed3be3.1335246446.git.viresh.kumar@st.com> <4F9671D8.4080308@arm.com>
In-Reply-To: <4F9671D8.4080308@arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 4/24/2012 2:56 PM, Marc Zyngier wrote:
> I'm sorry, but I really have to ask: What is the point of adding DT
> support to this driver when it is obvious that it is already broken?

Interrupt is only for testing. And that's why it worked for me earlier,
as i didn't passed irq from DT.

So, i believe this patch still makes sense. Obviously we can have another
patch to get interrupts fixed.

-- 
viresh
