Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5168 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757800Ab2EKKAe (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 11 May 2012 06:00:34 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: watchdog core + sch56xx patches
Date: Fri, 11 May 2012 12:00:18 +0200
Message-Id: <1336730427-1664-1-git-send-email-hdegoede@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi All,

As discussed in the "Re: [PATCH 1/4] watchdog: Add multiple device support"
thread here are Alan Cox's other patches rebased on top of Wim's new version
of that patch as well as my patches for dynamically allocated watchdog_dev
structs and sch56xx conversion to the watchdog core.

Regards,

Hans
