Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.nic.cz ([217.31.204.67]:39569 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbeH3Sbf (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 30 Aug 2018 14:31:35 -0400
Date: Thu, 30 Aug 2018 16:28:28 +0200
From: Marek Behun <marek.behun@nic.cz>
To: linux-watchdog@vger.kernel.org
Cc: wim@linux-watchdog.org
Subject: Re: [PATCH 1/2] watchdog: Add support for Armada 37xx CPU watchdog
Message-ID: <20180830162828.356ca519@nic.cz>
In-Reply-To: <20180830142243.12153-1-marek.behun@nic.cz>
References: <20180830142243.12153-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

Checkpatch complains about not adding the new .c file to MAINTAINERS.
As I am sending other patches to linux-gpio, which creates a new group
in MAINTAINERS file, to which this file should belong, but if I created
this group also here, it would result in a conflict.
The addition of this file to MAINTAINERS will be done in the patch sent
to linux-gpio. Is this ok, or shall I do it differently?
Thanks.

Marek
