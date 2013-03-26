Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34570 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759744Ab3CZJYk (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Mar 2013 05:24:40 -0400
Date: Tue, 26 Mar 2013 10:24:35 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] x86: Add basic support for the Congatec CGEB BIOS
 interface
Message-ID: <20130326092435.GB8553@the-dreams.de>
References: <1360663374-30951-1-git-send-email-s.hauer@pengutronix.de>
 <1360663374-30951-2-git-send-email-s.hauer@pengutronix.de>
 <CAH9NwWdOCo642KqUXk1y5hbwdtW5RYgQnQfZFUEe4FOJzSiByQ@mail.gmail.com>
 <20130326085454.GK1906@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130326085454.GK1906@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Sascha,

> Any other comments to this series? Is the base cgeb support ok to
> include?

I had a few comments to the I2C driver.

All the best,

   Wolfram
