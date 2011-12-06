Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:47395 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932697Ab1LFA1k (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 5 Dec 2011 19:27:40 -0500
From: Maxim Uvarov <maxim.uvarov@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be
Subject: [PATCH] hpwd watchdog mark page executable 
Date: Mon,  5 Dec 2011 16:25:38 -0800
Message-Id: <1323131139-32451-1-git-send-email-maxim.uvarov@oracle.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


Of course set up executable flag. Not writable :)

