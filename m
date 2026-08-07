Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE47721ABBB
	for <linux-watchdog@vger.kernel.org>; Fri,  7 Aug 2026 04:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786076452; cv=pass; b=UQXvHt8Smoh2HDuUQ5xvj2c4gd/LhpTDezMq+d0TyPdAfZI18HailVDrIjebPODm8VL9yfW2di8VKvWLw/y+wo1ddwXtXU4XeKK68bG1OWVG82CuVxdBQ94lh1DQ54nRk2lL32OkZr2k0pjZ2daK0ykuCyL5DpZuqShF88bUvGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786076452; c=relaxed/simple;
	bh=pK3JYEo5IZ8/K4/mjlbxzL5hahwxXLksza+ZWtlZvqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGTchHYJuWgCwtYzTnvxKarfJq0qYSF/ukrzyCmM8X6UuPHxUVi5FVAbVrTBcnAv1wPtfGZQ7kQeCxNqISc5m0CRV8YqqaB8QyYTlo9ZTdkvuzwcNZK5LYVjvW6bhV0wqbTLqXb3nL/k3YijFyQR8SI8TqXZvj0MbL/nFTSTrG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdIZx21i; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdIZx21i"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so2709656b3a.0
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Aug 2026 21:20:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786076450; cv=none;
        d=google.com; s=arc-20260327;
        b=nmQ9CpjKiqipfLs2lJ/gr3vpuJJPGYOe2fhtsoFTmpHDHy8w14OQcNWHhT48+S8pla
         woBmtOd2if2jOaJKAsQvZ5EAUiKFcmhTVg0Tg+zJurvS/gBrlseyWyNftHLXZA3cfowi
         /NxsRyEFgSncRDQhwAFMsK/SKtPVPDltZt44jws8ytchpfolOzvspzJQLgzB56LzPCXj
         ckTqArWvLEVh2ZJeWHyWBQt7LVaRbGMTGZrGASBwrHl76ruPUCk+Q7xc6IegPzONFPy2
         v04wF/Q1XTWEFfxoqUWXFwK3R9fbkt73hzPfLHforukd2OB3+x6dvrmXTKwWSYrpRk0Q
         jGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=o17xvsOvPfH9++tJha96HSgr/uQMNYHba+/ZUL89Qak=;
        fh=8hvCbK4WXWkCuD3mU0Q9vUGhu5sF2DYC5KY46zwM3sM=;
        b=s/79vvXq4KDfNE+qLR2pn+aBU5c4w6fTmkHWMGua5z06AZQpYZZOe6Iod/7LWqxsM+
         AeUH9enXyZMS7omG5W2zpc+nLtkJ6tCEYYlv+a+taSJzRkHCtp9i17/iQbdA9nZfcf41
         vkT/v3/evHcqalZIDVYp4S64HEoQvlQJ1ksXAw5EwfNjPVpcj65sw85gJ8qiR2IFZvE/
         cD5gvynvfmbdluEUX0/UsdbL/1g9M0M96F15Jfs4zgX6WUtLvIOgmXv0rlfK9Thi3Uj/
         RpTF85bVfF8FP5Qd0i7RfJINW+kuTd13NMV6iDe/Ss8T2FhuSY0RCYVEP/woB3VeoHyl
         ZtAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786076450; x=1786681250; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o17xvsOvPfH9++tJha96HSgr/uQMNYHba+/ZUL89Qak=;
        b=jdIZx21ikS5EBaP7HBY3wR3OhZ49lnXtxItIfeq1HiCmlIggAdXWvUBKalNbEWCSi+
         9j/yCCtqXpB6TkEXFTZcm2HKggxIFnVoDItpbUR1VEgMI7esuqswPJjiyZVf4u42ysc+
         O2kiJgoR2Axuf4Pqkb7JRZosWD+UYukblpIctNZCwSOPF+Pll1rJ1gRhdmVFJ4SmxtIb
         2d6f2fUsccrhB01ZtnDE3FpHzq2M+Zi7sfdUz82VrXGvggdZ0L3isjkQMPZAO/2c2Mng
         XIdlRQD9y57b4y72IBFhJmzx3DQXV0hTOi1mSZiGDWaSn3h0apbG/c6/a64sV1J9G+Ok
         nmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786076450; x=1786681250;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o17xvsOvPfH9++tJha96HSgr/uQMNYHba+/ZUL89Qak=;
        b=neNAfkelPCaV4SsmVb0lgDDdDT8ZNMAfAI0mABqWEcgCHh0np4mplI6ZFYrE3Lhx1Z
         HKvmFua68oMgyiVFm1Obt7t/JhcdyKrA3MfYqLBuZT3yYK9J18Gh+i30YBwvNQXSiwWW
         IYsPwhklezviy0hJ8TdPEYrckxi5ycKdSFsb1yl5dZ7Nq5foyGwa4ezNUhpUz1n45YHv
         w5OpmdCjX+83sLy58ash8+/yUR94o1TcpkJTua2VSxvU07JmW7i9ORKBKGy3rGxc7MrS
         lCBliKLc/kG7CnluuVPtAM138bU/BqmF58DghLj4TDMd+2qsEVFxyfbvPzGimio5/S9h
         lkgg==
X-Forwarded-Encrypted: i=1; AHgh+RpVRXqFedt4qt3OjB6JIgcuf0fIeBKfyJP+tJkftZSdQymnpLz2aRiRwwCWhVSNwaPO/+xCNxqJTPRoe+4Ovw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQJDjtELjehF0L1zGAHb7CxOT/qcmAWCorLWN0l0z83Ckhf+z
	Kpvr4RZ3rnjx9LNhiTUHwDmm7x4b4urMCTFafbWNWBaSK2tiO9duh4VlTny+jtL3hB7SILrp8Y4
	X8l3FSzYEtJMtxcj2hWJXvYkxBGXqtzo=
X-Gm-Gg: AR+sD13z6arbhAv/danY7ZKETn3SipdMiPt9yIikMffWxxvKDXJ0/bTqBAPRyvVhOvH
	+m50MvZ9v0Xb7nMXf+PkCRhGWzvomJiVc6Swx5LgQJd0jlqGxaNx9VpgTP65wZaMST/no6yqwOX
	HM5x3JeFSdRNAYi5MzvslYiXF9RLH62QMwPoDuteKEIysJSsTDoharDSNzL/ZwJ2HLbhkgQdUET
	LTcrVU8XaOrUHLt399S4UhTv+gLM2gyr7LvZoO6r8MMK9HdWLZtM+k0LNwXKKdwoIXdjMGZZpmv
	kHZK5iK9c/O3DVIqyi0xRFeUhhrfyCGKLemG8ThLJSg3zFn9QlgWKgGcTMqgs10DQhsCXI5Lq0l
	VdciF4msG73tmSCpDfb6oG9FPDUendRjO8O6Dcn6B1NJyi+f+1QOdjk0W
X-Received: by 2002:a05:6a00:983:b0:842:3a3b:d6e7 with SMTP id
 d2e1a72fcca58-84f2e052333mr20477801b3a.23.1786076449911; Thu, 06 Aug 2026
 21:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806062812.26523-1-phucduc.bui@gmail.com> <81cf90a0-a966-4cab-b5ea-ceb1d241fb3f@roeck-us.net>
In-Reply-To: <81cf90a0-a966-4cab-b5ea-ceb1d241fb3f@roeck-us.net>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Fri, 7 Aug 2026 11:20:38 +0700
X-Gm-Features: AUfX_mwHvUlwr7cFbF1Ulitt4ashrEr_f7sBsQ9dvhUOUgB7zPiirsw1gqcqaS8
Message-ID: <CAABR9nEys_RZqpYEqhq+LGwWc1Fan3cN8mLSrejM+8vAnFOn0A@mail.gmail.com>
Subject: Re: [PATCH 1/2] watchdog: orion_wdt: Propagate -EPROBE_DEFER from IRQ lookup
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

Thank you for your review.

> > +     if (irq == -EPROBE_DEFER)
> > +             return irq;
>
> I think this should be
>
>         if (irq < 0 && irq != -ENXIO)
>                 return irq;
>

Agreed, that's better.
 -EINVAL also deserves to be returned, not just -EPROBE_DEFER
 only -ENXIO really means "no IRQ".
Will send v2 soon.

Best regards,
Phuc
