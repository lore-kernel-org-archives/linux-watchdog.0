Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45176 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701Ab2DINCc (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 9 Apr 2012 09:02:32 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q39D2VbK032319
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-watchdog@vger.kernel.org>; Mon, 9 Apr 2012 09:02:31 -0400
Received: from shalem.localdomain (vpn1-7-241.ams2.redhat.com [10.36.7.241])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q39D2UFU030192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <linux-watchdog@vger.kernel.org>; Mon, 9 Apr 2012 09:02:31 -0400
Message-ID: <4F82DE6C.3070803@redhat.com>
Date: Mon, 09 Apr 2012 15:04:44 +0200
From: Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
To: linux-watchdog@vger.kernel.org
Subject: watchdog_dev is not smp safe?!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

While working on converting my sch56xx watchdog driver to watchdog_dev,
I noticed that watchdog_dev.c does not do any locking.

At a first look this may seem ok, since only 1 open is allowed, but
a process with /dev/watchdog open could use threads or fork and
that way still make multiple write / ioctl calls at the same time.

This causes 2 potential problems:
1) watchdog_start / open do an unlocked test_n_set / test_n_clear,
    if these 2 race, the watchdog could be stopped while the active
    bit indicates it is running or visa versa.

2) Most watchdog_dev drivers probably assume that only one
    watchdog-op will get called at a time, this is not necessary
    true atm


Notice that 2. is fixed by my "watchdog_dev: Add support for dynamically
allocated watchdog_device structs" patch which is still pending review.

Changing that patch to also fix 1. is quite easy. But before I put
more work into that patch I would first like some feedback on it ...

Regards,

Hans
