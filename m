Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18C03E1208
	for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994776; cv=none; b=nYOWTbH5H4JukFja7ORXDm5Vfa0L9DlD1cQxYjwqck7IjU6/iTCbZFCVtgXEoHw7xypXG7th26IPVDVja1Iei8LOVMMcOlkWMy130hg0OvQhutTALF1JFxN9UUC9nnmZFvUkInIPshamzhM9F3TKWq9P2Cwc8I1BYI1a5svfuc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994776; c=relaxed/simple;
	bh=DVgizKVpuB08U7drflvR/Nm9xyLIrxGf4hC+AIIeucU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlOjiYEMCSB5YY6kj6NV6gc1Z2lNKDbP8NIsOAxawdvEovEfskDHceNrjhr3VvLqZjhiObY7LwoF0H1CIjSze05B0WpMmO5I9BYKIlWKL7exE4fgTz9wRbz8LLGZksjT4SDaEDzfBa0nsqRX5UMKgayo/LnRXpEd55Pu/hJv864=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFbx3p/0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFbx3p/0"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2caced6038eso3451955ad.0
        for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 12:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786994774; x=1787599574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DnkWDGpHcDpKI6ZJE2YuZxstTmPwSlwlz2aFP0o410o=;
        b=SFbx3p/07jQI0SvdSXIF8yC8RZvRKYnCN/EltB0vMLy0zOhKVdkcMPOSKFVwL42wOm
         qeg5oaifBjh18YwDqcAbTMTYWT1MpUL4C8ERVv47Or8ZoxqQEhPz8PGIQmz/N1IuFG0N
         hLhF7QePDxLD3MAaeZNYWe46xvZzeiIeL9GCRjIrEWXAfj8qUCOYSKdo7QW77SzJhipu
         owSj0zaEoB2btjiEoenyqZ0E1vPYXFMYS56Pb3VPQ8M1JY0cLkAoKnHxLi7ADRuaIWgc
         TiLOGWjObtenPWhM5wjYSOpDZowkwDapb720qZRN7tCYxSWy5FutRjroWTD4ReFozpbi
         cOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994774; x=1787599574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DnkWDGpHcDpKI6ZJE2YuZxstTmPwSlwlz2aFP0o410o=;
        b=czXoYlpE7aEQLmeDV1HTBKL9REYeJUnYX47We6N0G098EdbXUiwsqEn8jH5JWG9Ico
         J5VQvzmOp+8lrID4Vz7jd1ANLFLt+VmqrgS016Q0v4VOgisecFzXJsvAa5sxYfbEnTuL
         4y/vCDpTS07OVsyGJ+4k8ArrGZnSew/+ip71RG1x7PnPsxgUgoiWd3VKImZNZrCtnnWz
         dbe0RykB8Vf6S7jran5ZM9mu7keE1LDK+DOUDPgSGpOgb8Img5zC5PARrXcxiK5Q2rSs
         Rx/wfBB6rY8sdij+Vvp08acgR7VlTn7rESDTGOxB8lGq/qyil+muSPyR5CI2yJlp4J9b
         4wTQ==
X-Gm-Message-State: AOJu0Yyke8zlx7a8A6bLzgZD+LsXrSuzWEHdBsiL3SH2zWHuqKG1AZbw
	yg9KnWiQdpn3Xs/zPZ/7eeyXn6XmTCn4te7q7PUQ7CtrFN3+I42z5fYj
X-Gm-Gg: AR+sD10wnDVDF1BfPTw2pSrKLaf8B6G0f329Ft9x4KnQFxUJv4X2epq3x7QPUU+f7KQ
	17t8pAuyhCRUClp3o3I1rtPSs421Llrcg3jFsSapTGt0HWDV8I0RjhbjCBTK3ZC/TL3qykZKsHU
	/du8zdK4gQAWqSfrXNownE0D/v/RZSsJuOcxsZhJUG+jL1SOHdU9fxk6lKv+9zcLoOlznbceAco
	6acOKRpApuxUbH8/6eOJwhK6gMPSp4ohg7QwWlDTCkEfzXoe2gKmdoR7k0Gv6ryupHZgaDChpzn
	SnnYqM12H0pM/EPGrHL/ZqHsn665IYBDrSKTmoSnvv5HQuAz7hm6pEUa1UgXfiBVZQ06c3u5+Jr
	Csp6q6LHgggI2pKqsDfkWmOPy7tRDwOn59SqllDl5U5joHfBhQiKYzQws+Ic+n1K8IRkgyNjzYG
	DiWhXlkhzNEu+6BH4txw1uOVjEFHrMidyUmumvvm+XktdtBiTCo3kpCShOwMDnoy8dT2Y1WEHSz
	qnM82Pun3GPiPwcdAz4netl1OgMlx4q1bObGINNOBT7EjYzT/Qb5I22YlrsdpEMaetKXHhLg9Dm
	ZxAtCkSlJw==
X-Received: by 2002:a17:903:3bcb:b0:2c0:d94f:50c7 with SMTP id d9443c01a7336-2d5cac820d6mr11280805ad.7.1786994773992;
        Mon, 17 Aug 2026 12:26:13 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c06:2735:f886:32ae:1e17:ec13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-326798cb9f5sm10218757eec.13.2026.08.17.12.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:26:13 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 3/7] arm64: dts: renesas: r9a09g087: Adjust CPG register region sizes
Date: Mon, 17 Aug 2026 20:25:36 +0100
Message-ID: <20260817192540.423994-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Increase the size of both CPG register regions from 64 KiB to 128 KiB.

On the RZ/N2H SoC, the CPG/MSSR block is a multi-function block where,
apart from clock and reset handling, it supports other features including
clock monitoring, write protection, and peripheral configuration registers.
Expand the mapped register regions to cover the entire register space of
this block so these additional features can be utilized.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- No change

v2->v3:
- new patch
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index d5b3eb6c1736..813bb0cb021c 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -1078,8 +1078,8 @@ xspi1: spi@801c1000 {
 
 		cpg: clock-controller@80280000 {
 			compatible = "renesas,r9a09g087-cpg-mssr";
-			reg = <0 0x80280000 0 0x10000>,
-			      <0 0x81280000 0 0x10000>;
+			reg = <0 0x80280000 0 0x20000>,
+			      <0 0x81280000 0 0x20000>;
 			clocks = <&extal_clk>;
 			clock-names = "extal";
 			#clock-cells = <2>;
-- 
2.43.0

