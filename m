Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:58251 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab3C0DtN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Mar 2013 23:49:13 -0400
Message-ID: <51526C37.5070400@wwwdotorg.org>
Date: Tue, 26 Mar 2013 21:49:11 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Lubomir Rintel <lkundrak@v3.sk>
CC: linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-rpi-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: Add Broadcom BCM2835 watchdog timer driver
References: <1364135137-26691-1-git-send-email-lkundrak@v3.sk> <1364320200-23569-1-git-send-email-lkundrak@v3.sk>
In-Reply-To: <1364320200-23569-1-git-send-email-lkundrak@v3.sk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/26/2013 11:50 AM, Lubomir Rintel wrote:
> This adds a driver for watchdog timer hardware present on Broadcom BCM2835 SoC,
> used in Raspberry Pi and Roku 2 devices.

Tested-by: Stephen Warren <swarren@wwwdotorg.org>
