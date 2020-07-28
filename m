Return-Path: <SRS0=DRey=BH=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12523C433F2
	for <linux-watchdog@archiver.kernel.org>; Tue, 28 Jul 2020 10:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DADEB20786
	for <linux-watchdog@archiver.kernel.org>; Tue, 28 Jul 2020 10:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BYdWWas9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgG1Kna (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:43:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:9906 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728709AbgG1Kna (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Jul 2020 06:43:30 -0400
X-UUID: 4e32ed1c65404e198558d1d29ecdd233-20200728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Dw3IQyGg4pE5zkiPd+QC9P5t/IY8wdV20m7D09enpVw=;
        b=BYdWWas937HhWp1njwh9n2SWuw5QAD3o+qifB3BAuG9SsYDACF9zbjbwNWarWRH7L5l9lUHGs1gP74qk8ZZVVWZJ8GsCbhCQxX/0UPEkoqI7AtlksaspfSnbI+GPdh16h3Fd15qzkArPxsvKGXC8y9xzM6Zv6jtwAS9s7eRRIxE=;
X-UUID: 4e32ed1c65404e198558d1d29ecdd233-20200728
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1582942344; Tue, 28 Jul 2020 18:43:26 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Jul 2020 18:43:24 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Jul 2020 18:43:22 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <seiya.wang@mediatek.com>, Crystal Guo <crystal.guo@mediatek.com>
Subject: [PATCH 2/3] dt-bindings: watchdog: Add rst-num property
Date:   Tue, 28 Jul 2020 18:42:28 +0800
Message-ID: <1595932949-7033-2-git-send-email-crystal.guo@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1595932949-7033-1-git-send-email-crystal.guo@mediatek.com>
References: <1595932949-7033-1-git-send-email-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4AE3E7CC99CCFE9FF0F576862D147629AD17970E556E9E6452DFBA34C0985FE42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

QWRkIHJzdC1udW0gcHJvcGVydHkgYW5kIHVwZGF0ZSBleGFtcGxlDQoNClNpZ25lZC1vZmYtYnk6
IENyeXN0YWwgR3VvIDxjcnlzdGFsLmd1b0BtZWRpYXRlay5jb20+DQotLS0NCiBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvd2F0Y2hkb2cvbXRrLXdkdC50eHQgfCAyICsrDQogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3dhdGNoZG9nL210ay13ZHQudHh0IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3dhdGNoZG9nL210ay13ZHQudHh0DQppbmRleCA0ZGQzNmJk
Li5kZjE5YTRkIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3dhdGNoZG9nL210ay13ZHQudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvd2F0Y2hkb2cvbXRrLXdkdC50eHQNCkBAIC0xOCw2ICsxOCw3IEBAIFJlcXVpcmVkIHBy
b3BlcnRpZXM6DQogT3B0aW9uYWwgcHJvcGVydGllczoNCiAtIHRpbWVvdXQtc2VjOiBjb250YWlu
cyB0aGUgd2F0Y2hkb2cgdGltZW91dCBpbiBzZWNvbmRzLg0KIC0gI3Jlc2V0LWNlbGxzOiBTaG91
bGQgYmUgMS4NCistIHJzdC1udW06IHRoZSBudW1iZXIgb2YgcmVzZXQgYml0cyBpbiB0b3ByZ3Uu
DQogDQogRXhhbXBsZToNCiANCkBAIC0yNiw1ICsyNyw2IEBAIHdhdGNoZG9nOiB3YXRjaGRvZ0Ax
MDAwNzAwMCB7DQogCQkgICAgICJtZWRpYXRlayxtdDY1ODktd2R0IjsNCiAJcmVnID0gPDAgMHgx
MDAwNzAwMCAwIDB4MTAwPjsNCiAJdGltZW91dC1zZWMgPSA8MTA+Ow0KKwlyc3QtbnVtID0gPDIz
PjsNCiAJI3Jlc2V0LWNlbGxzID0gPDE+Ow0KIH07DQotLSANCjEuOC4xLjEuZGlydHkNCg==

