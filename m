Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:52233 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751875AbaAMUBH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 13 Jan 2014 15:01:07 -0500
Date: Mon, 13 Jan 2014 21:01:03 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Baruch Siach <baruch@tkos.co.il>
Cc: linux-watchdog@vger.kernel.org, Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH v2] watchdog: dw_wdt: remove build dependencies
Message-ID: <20140113200103.GA23002@spo001.leaseweb.com>
References: <a41f433ac50ef0da9e9eae0e793119cb4e88b9e3.1388406354.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a41f433ac50ef0da9e9eae0e793119cb4e88b9e3.1388406354.git.baruch@tkos.co.il>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Baruch,

> There is nothing ARM specific in this driver, and we intend to use it on the
> Xtensa architecture. Also, clk.h now includes stubs for !CONFIG_HAVE_CLK, so
> the driver should build anyway.
> 
> Cc: Jamie Iles <jamie@jamieiles.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Added to linux-watchdog-next.

Kind regards,
Wim.

