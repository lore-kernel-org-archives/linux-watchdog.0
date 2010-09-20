Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:52061 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab0ITSvn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 20 Sep 2010 14:51:43 -0400
Received: from mail135-tx2 (localhost.localdomain [127.0.0.1])	by
 mail135-tx2-R.bigfish.com (Postfix) with ESMTP id F1F565E8079	for
 <linux-watchdog@vger.kernel.org>; Mon, 20 Sep 2010 18:51:40 +0000 (UTC)
Received: from TX2EHSMHS009.bigfish.com (unknown [10.9.14.246])	by
 mail135-tx2.bigfish.com (Postfix) with ESMTP id B540818C004C	for
 <linux-watchdog@vger.kernel.org>; Mon, 20 Sep 2010 18:51:40 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
 o8KIpcEN008038	for <linux-watchdog@vger.kernel.org>; Mon, 20 Sep 2010
 11:51:38 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
 [10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
 o8KIpiAM026985	for <linux-watchdog@vger.kernel.org>; Mon, 20 Sep 2010
 13:51:44 -0500 (CDT)
Date: Mon, 20 Sep 2010 13:51:36 -0500
From: Scott Wood <scottwood@freescale.com>
To: Josh Boyer <jwboyer@gmail.com>
CC: Tabi Timur-B04825 <B04825@freescale.com>, linuxppc-dev@ozlabs.org,
	Gala Kumar-B11780 <kumar.gala@freescale.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can
 reference it
Message-ID: <20100920135136.04ceb772@udp111988uds.am.freescale.net>
In-Reply-To: <AANLkTi=RXjc=GZ+RRsKjL3qdYFayXOCX0s1SU5jojeXg@mail.gmail.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
	<AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com>
	<AANLkTinidrifo3ry7o=DPKF96f3o4+_2zt7rsn=Zvh9D@mail.gmail.com>
	<1284779678.30449.108.camel@pasglop>
	<AC849F1A-BC8A-4705-90E0-26991FAE6EED@freescale.com>
	<70810686-1EB6-4AD9-A89B-C2A8BA6AC30D@freescale.com>
	<AANLkTi=sa1LJOnw4fK-fX23Egxm7NoJVNKB1vtc9Eg4q@mail.gmail.com>
	<5610599F537DD74A8D1F5CC946A75073034792F7@az33exm25.fsl.freescale.net>
	<AANLkTimSewEEhbBoBb+fpPgY9EbE5bWsknPS7OkQgkcy@mail.gmail.com>
	<5610599F537DD74A8D1F5CC946A75073034792F9@az33exm25.fsl.freescale.net>
	<AANLkTi=RXjc=GZ+RRsKjL3qdYFayXOCX0s1SU5jojeXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, 18 Sep 2010 14:22:12 -0400
Josh Boyer <jwboyer@gmail.com> wrote:

> Capitalizing?  The patch you posted that uses this symbol is for a GPL
> driver so you gain or lose nothing by having this symbol be
> EXPORT_SYMBOL_GPL.  Are you somehow advocating and getting some sort
> of gain by allowing non-GPL modules?  If so, I find that unfortunate.
> If not, then I guess I don't understand what you mean by capitalizing.

One can dislike DRM (even a very weak form such as this) without having
a particular desire to go outside the bounds of what it allows.

I thought EXPORT_SYMBOL_GPL was originally meant to indicate the
symbols whose use is likely to be indicitave of code that is, in some
copyright-meaningful way, derived from GPL code?  I have a hard time
seeing that being the case here.  If every symbol is made GPL-only,
then that just gives the binary-only people[1] more incentive to
circumvent the entire mechanism.  It loses its meaning.

Documentation/DocBook/kernel-hacking.tmpl says, "It implies that the
function is considered an internal implementation issue, and not really
an interface."

-Scott

[1] Plus anyone who might want to make a kernel module out of code
which is open source, but not under a license the GPLv2 is compatible
with.

