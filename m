Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:53164 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754666Ab2EHRNE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 8 May 2012 13:13:04 -0400
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Xie Shaohui-B21989 <B21989@freescale.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: Xie Shaohui-B21989 <B21989@freescale.com>
Subject: RE: [PATCH 2/2] powerpc/watchdog: replace CONFIG_FSL_BOOKE with
 CONFIG_FSL_SOC_BOOKE
Date: Tue, 8 May 2012 17:12:57 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D03CF6925@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1336457276-32611-1-git-send-email-Shaohui.Xie@freescale.com>
In-Reply-To: <1336457276-32611-1-git-send-email-Shaohui.Xie@freescale.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: linuxppc-dev-bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.=
org
> [mailto:linuxppc-dev-bounces+bharat.bhushan=3Dfreescale.com@lists.ozlab=
s.org] On
> Behalf Of Shaohui Xie
> Sent: Tuesday, May 08, 2012 11:38 AM
> To: linux-watchdog@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Cc: Xie Shaohui-B21989
> Subject: [PATCH 2/2] powerpc/watchdog: replace CONFIG_FSL_BOOKE with
> CONFIG_FSL_SOC_BOOKE

CONFIG_FSL_SOC_BOOKE looks like for SOC config option and watchdog is cpu=
 feature.

Should not we use PPC_FSL_BOOK3E?

Thanks
-Bharat

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
