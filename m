Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:45294 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752297Ab2EQIrY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 17 May 2012 04:47:24 -0400
Date: Thu, 17 May 2012 10:47:21 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Devendra Naga <devendra.aaru@gmail.com>
Cc: Rob Landley <rob@landley.net>, linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/watchdog: close the fd when cmdline arg given
Message-ID: <20120517084721.GV3074@spo001.leaseweb.com>
References: <1337019122-17300-1-git-send-email-devendra.aaru@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1337019122-17300-1-git-send-email-devendra.aaru@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Devendra,

> in the watchdog test code, the ioctl is performed on the watchdog device
> and just doing exit(0) so we leak a filedescripor.
> 
> Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>

Patch added to linux-watchdog-next.

Kind regards,
Wim.

