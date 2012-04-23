Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:52277 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab2DWQQY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Apr 2012 12:16:24 -0400
Received: by wibhq7 with SMTP id hq7so3056207wib.1
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Apr 2012 09:16:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F957F62.5090605@arm.com>
References: <18a4584c24041ceb8a1972dd5ee70cf7c59fed21.1334932839.git.viresh.kumar@st.com>
	<7dbd64f72527cf92af0ec38f45275d71207d5ec5.1335008301.git.viresh.kumar@st.com>
	<4F9514AA.10403@arm.com>
	<CAOh2x=kroSi8MZBhYVOhrDm08q1B9LS_9P7NPAfHC01-MHaOCQ@mail.gmail.com>
	<4F9547E3.4000709@arm.com>
	<CAOh2x=kQvjP5SYfJsTXkZyNe3UsS-=pXUBKoQ=SsMUNcPGjzuA@mail.gmail.com>
	<4F9573B8.9050607@arm.com>
	<CAOh2x=n5Zm9MR5twDY-CUA-ppE9ADXrg25XCT5RKM++v6=tcpA@mail.gmail.com>
	<4F957A0C.7060607@arm.com>
	<CAOh2x=kyJ3tG3go0TQ2LXLOKDf0m9=uz1=KC7asMS0FSxtx9uA@mail.gmail.com>
	<4F957F62.5090605@arm.com>
Date: Mon, 23 Apr 2012 21:46:22 +0530
Message-ID: <CAOh2x=n4JdZdZoofHpr+9G254ZL_kxyWEHHRr5W4PB4GgjeHsQ@mail.gmail.com>
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
> Well, it definitely should. Can you share the relevant part of your DT?

I Just tested it once, and will do it tomorrow again.

			wdt@ec800620 {
				compatible = "arm,cortex-a9-twd-wdt";
				reg = <0xec800620 0x20>;
				interrupts = <1 14 0x301>;
				status = "disabled";
			};

Looking at your confidence, i am starting to feel, i am wrong here ;)

--
viresh
