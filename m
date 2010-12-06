Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from passoire.arboi.fr.eu.org ([81.57.108.63]:38591 "EHLO
	passoire.arboi.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab0LFWmQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 6 Dec 2010 17:42:16 -0500
Date: Mon, 6 Dec 2010 23:42:13 +0100
From: Michel Arboi <michel@arboi.fr.eu.org>
To: Giel van Schijndel <me@mortis.eu>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Patch for Fintek F71869 watchdoh
Message-ID: <20101206234213.4e3c6ae6@marmite>
In-Reply-To: <20101206202155.GB3188@salidar.me.mortis.eu>
References: <4CFCB76D.2060405@redhat.com>
	<20101206191930.GA3188@salidar.me.mortis.eu>
	<20101206205345.639f31bb@marmite>
	<20101206202155.GB3188@salidar.me.mortis.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 6 Dec 2010 21:21:55 +0100
Giel van Schijndel <me@mortis.eu> wrote:

> That's intended behaviour and probably sufficient for testing.  Most
> of the behaviour isn't chip-specific, only the initialisation and
> configuration of the chip is specific to that chip AFAIK.

OK. Hans, if you need some tests for the sensors part, you can send me a
patch and I'll try to help.
[I suspect that the current Linux code works, sensors reports 62 °C /
59 °C for the CPU]

> PS You might want to include patches inline (i.e. as part of the
> message text) as that's standard procedure for Linux MLs.  That
> allows easy reviewing and commenting on patches.

OK. In fact I did not know how to submit a kernel patch. 
