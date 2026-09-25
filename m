Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6BE3C9EE7
	for <linux-watchdog@vger.kernel.org>; Fri, 25 Sep 2026 04:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790311858; cv=none; b=PPuhCNBErFvXk65Z3wQ84iEko9zW646sjkoFZmUhrmuQN26x6a1SW9d2pTm+BLdK/H66R9xRxito0WBNE7OjpA2tcU8awIrq0cfxA3cZ1uJp0gnQSahG07FIAAV3LmV2wKv0SiFW7Wkwb2MnxBeYa2D9KcaZbTVt6dGuKkRKU/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790311858; c=relaxed/simple;
	bh=Jda9Cr+a/gQLEGQJCn78dqhXEbQP7tafcvv2YamXTSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qw2XE3HL2pDdcCuzArNmevuvP+xMmgvkuOuCj9bAmjzi5XHbYlPz4LfsMixG+CTZL2wjo2FZvyoM6rLWAo5ieiesX5Y4vABSugCktlVmNRIvIyRYmC2vtVoJdjxJFucF4SEFS+NlEXoKL8Xwt2/52cw3DTRKrT30hOeHz6W5qBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VD/E6LCe; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD/E6LCe"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-8803b31af06so152101b3a.2
        for <linux-watchdog@vger.kernel.org>; Thu, 24 Sep 2026 21:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790311853; x=1790916653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/rCNzKY8hj1VkaRGisgTod/0wIazqSGTBqvD8A0lflc=;
        b=VD/E6LCe/N0Ay/bR6Bv72nupQhSwwDgXcNwnpA8E8ytKNz81MhrcS53fSyqBtDXplE
         l7stCTXWKLbR+fNpVI3gWrqRTOtBxaebfrDvIUHiQuvtOie6wxtSXZHZ9FJx86r2zC84
         9rLwJwNi8eLXwQPOiUM6ipw/BteSt32qjjOiHAovYYhhxY43kBWQwP/YP6A21v/SGNll
         U6c9r8L++x4EyGrWLom7NSk921fy2Lskr6udZ3gdMvWa838LDvpP5FVm4j9Gc/oTkNK5
         iEYNzV/LJMe9HQN6orGQtx8uCzEfvsoL0LH4jawCd6DgNIo0PkSMbh/Iu6ALdo9iWFMZ
         adaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790311853; x=1790916653;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/rCNzKY8hj1VkaRGisgTod/0wIazqSGTBqvD8A0lflc=;
        b=0wxapS7VG72bMTedm94wYkrupC6ggz+N+bi+1RNubML9f2SXS+OhQa7HOBJV3A4KjG
         IYYJmeISkFqE8QYE3KN4p/0zVkO0IPDT6vAIibzG4xMzrtmlpWIrDaXGV9evitF4KHm7
         8thzKZV0E0yF/4j9H0WmizbdlssmXbIMkqxCBzuVL4Fk66tE9vUSJdWKDRtwMP8ssKPD
         6u7Y7rmJaRIHffZE3ZLEVAMiYgB4slEzQ1i8daOOfjHUqrQhk5h+iJB6Pv9XCml1uS1Q
         cy7zxEXcZGtEwTZP0t4o+ANiwTVXViNXqX0hqt0OfFhhNn1K8AqbApX/ZwoeIWnyJoED
         xjIw==
X-Forwarded-Encrypted: i=1; AKwUvByuJTxgUSa3HLS39fPDpBHagKuxPBho1of56Tqh41aFMOQdKVLiBLRGzui9KbQXBRkm0Pte/XfgdvXH0UnFAQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kQ2f1Cr6ths0iqlt/j/sqSHCZvssEHLv7pfhw9APvNcdMY7DbH
	iqMcZCV3jmJbDt1xqLqOntNTavZC8XWTfz94nUmI/QZM53UI0CxS4uyF
X-Gm-Gg: AYBFou2mZ05s9JBZGXc/jMC4wi4LAbnAE98Dl6cFsGQPd299bbiihVcW34ZwR69aXwC
	a1S7uT94IaJ6Eaao5PM3PbyfJXp5i4JOQGyDZ7AB7neVVyaAnLfrEXBEw4PbUPn5w5PnhkrfNNR
	O3wAW8ZlcJayRPCJtgDB8XUO5ZjOoYoOX9hU4iqJHclU3S+nFYerFg5RW7appJTa283FKIlGWcH
	c2DFNWIpvWqHDWiq70ICruzndMF3g50SdO6yDnMhp0zGkjhkjL++bQ2+0C8t4ejScGIP8kZeEuX
	hZtuAg3nz3/vVs8PdeCY/A1Ea4X0ssF0H+Ucrquii5hz6iWupmvEu7TH9qjG6dbr+PataZFH5M6
	1DAhGMGxkOEHFtHfAH3hSAC/YK2JXQHMn6wfillFPyfP1JAGDfwZDzXyeTAFZpSTMrz5PUnSxSy
	LHjsD4/M+hbUDz1juwjfAmg45kE7GzFakRfyvYuP3freMAAYjeb1TPr2LDsotmN9K4US4wzIAWO
	qCcogHGbaE+
X-Received: by 2002:a05:6a00:2d06:b0:87c:d962:72cb with SMTP id d2e1a72fcca58-87e9ef53f21mr3522647b3a.40.1790311852836;
        Thu, 24 Sep 2026 21:50:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87feaf89651sm463483b3a.41.2026.09.24.21.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 21:50:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 24 Sep 2026 21:50:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	wsa+renesas <wsa+renesas@sang-engineering.com>,
	"robh@kernel.org" <robh@kernel.org>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v6 6/8] watchdog: rzv2h: Add syscon support for WDTDCR
Message-ID: <2d32d7f1-f87b-45b3-9ccd-95e9773ca658@roeck-us.net>
References: <20260923104054.3324830-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260923104054.3324830-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260923105237.7B87D1F00893@smtp.kernel.org>
 <CA+V-a8uD16uG8cc9m7NHVZXT5bU64TYfu+_1POuXeioRAy6Z+A@mail.gmail.com>
 <4f5aadf0-8f23-4871-918f-430a0c99900d@roeck-us.net>
 <TY3PR01MB11346CC8B3C7374C293E0F3EB86802@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346CC8B3C7374C293E0F3EB86802@TY3PR01MB11346.jpnprd01.prod.outlook.com>

On Fri, Sep 25, 2026 at 04:13:24AM +0000, Biju Das wrote:
> Hi Geunter/Prabhakar,
> 
...
> Just a question,
> For automatic software upgrade, if the reboot using PSCI fails, what is the fallback
> for reboot, reset the board?

That seems to be a bit theoretic. The reason for having the ability to
register multiple restart handlers is not to have failure fallbacks,
but to have fallbacks if preferred restart handlers are not available.
If the PSCI restart handler is present, it is expected to work.
That is why it has higher priority. The idea is to use the highest
priority restart handler, not to try one after another.

Sure, the failure fallback works as well, but that doesn't mean
that fallbacks should be provided just to provide fallbacks.

If you claim that the PSCI restart handler does not work on this
system, provide evicence, and we can discuss this further.

Thanks,
Guenter
