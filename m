Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55489 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751175Ab1EDJcB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 4 May 2011 05:32:01 -0400
Date: Wed, 4 May 2011 10:32:23 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nat Gurumoorthy <natg@google.com>
Cc: Jean Delvare <khali@linux-fr.org>,
	Guenter Roeck <guenter.roeck@ericsson.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Mike Waychison <mikew@google.com>, lm-sensors@lm-sensors.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v7 0/2] Make all it87 drivers SMP safe
Message-ID: <20110504103223.547dd9e1@lxorguk.ukuu.org.uk>
In-Reply-To: <1303153127-11717-1-git-send-email-natg@google.com>
References: <1303153127-11717-1-git-send-email-natg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

All looks good to me.

Parport can also be made to behave politely and I'll post a patch for
that.

Acked-by: Alan Cox <alan@linux.intel.com>
