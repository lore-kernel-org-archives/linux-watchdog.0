Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:36086 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754169Ab2LLUgC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Dec 2012 15:36:02 -0500
Date: Wed, 12 Dec 2012 21:18:09 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: "devendra.aaru" <devendra.aaru@gmail.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: watchdog: del_timer call missing on the cpu5wdt.c
Message-ID: <20121212201809.GA30880@spo001.leaseweb.com>
References: <CAHdPZaMo6P-OA84NAGyXRArm1Hjc9xvo1zAMiG2N-w3me8RnWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHdPZaMo6P-OA84NAGyXRArm1Hjc9xvo1zAMiG2N-w3me8RnWQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

> We do a setup_timer at init stage of the module, but we didn't
> de-activate the time using del_timer.

Added to linux-watchdog-next.

Kind regards,
Wim.

