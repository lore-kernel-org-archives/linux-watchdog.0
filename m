Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61214 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755490Ab0IKAJ6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 10 Sep 2010 20:09:58 -0400
Date: Sat, 11 Sep 2010 02:11:48 +0200
From: Lutz Ballaschke <vegan.grindcore@googlemail.com>
To: Giel van Schijndel <me@mortis.eu>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 0/3] watchdog: add f71862fg support
Message-ID: <20100911001148.GB13116@kreios.titan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi everyone,

this patch adds support for the watchdog included in Fintek f71862fg
Super-I/O chip to the f71808e_wdt driver and adds WDIOC_GETTIMELEFT
ioctl which i found very helpful. 

Differences to PATCHv1 are
 * module parameter for WDTRST# pin configuration added
 * checking/printk of WDTRST# pin config 
 * removing int typecast

This patch comes in three parts:
1/3: add f71862fg support
2/3: add WDIOC_GETTIMELEFT ioctl and helper function
3/3: clean up/replace some magic numbers/constants

Thanks for the comments,

Lutz Ballaschke

 drivers/watchdog/f71808e_wdt.c |   66 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 61 insertions(+), 5 deletions(-)
