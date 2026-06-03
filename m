Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D6630C165
	for <linux-watchdog@vger.kernel.org>; Wed,  3 Jun 2026 04:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780459371; cv=none; b=Ddyghj912M1XIxTEo7apgxIBQc+HJysM636JAWf8eUe0+Yn5ETzci3s11s/wMK8LumavpFOX/TnAwuP05IT1tNQ67XmHO6gHECByuekvM4ep1vY/LVyBQWuvntMFlHDRJPhv+2UrNXrXaI1MplL1jRLVWxQeyjcg1yEMelnMpYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780459371; c=relaxed/simple;
	bh=YUxQ1DApuGWu4x+J/ulTyonKm/YOgUpd4al+GFqp968=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VadikuKNwfc4DaLkYzfRsXe1cqoVigiTaTh2NcupMeRmO1OG2E4GgMDPiAqbJvqe8RdVYtlw14UjQmMMQJv95JpQRLm9vfR7r+4kc7GCf218BEcei8qWmRbBO7f9SJFuteUz2w2+mGonNJH+gjhKnuzlBZr8Sm0FljQ0EfeqRIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDnRKD8a; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDnRKD8a"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9158629a220so105742785a.1
        for <linux-watchdog@vger.kernel.org>; Tue, 02 Jun 2026 21:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780459369; x=1781064169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fwhuqQvDA/JbpkL0q5tPDaoUbGYXPp2vE5OG+WYg69M=;
        b=bDnRKD8aJW1zoBQab/Qlb6hUNlk1buVzeRljeUMn86isdOoe6wz7gXwn/ET8ofmOO4
         vFnWkbim0QHNLBhVAj37zj26MPVe8DVC5txmDRm9TdqGlZJsjxDl73Fr0BDjQLRPCiff
         rd7q1Yd+33RUeH41RmoSBEwrMWmqKyORno4rImFWsp5Vd/7WZRtfLOIeYWd5Y30+MdT3
         IUBxh3oSZUatc3/uKfqbfkm/uQfjnkjwwi0MR0JzR6qP60wPsUOV5UENnwAw/KmeRNuY
         0DA04EXvSU99LEOjYemaUKefw0vbHSCF4L2PfYxghZWoSlhLrMgQ/s8xmK8fL5CGAH4t
         B8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780459369; x=1781064169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwhuqQvDA/JbpkL0q5tPDaoUbGYXPp2vE5OG+WYg69M=;
        b=FSPlFsLx2vUXBgAscE0NBq+tBa84LhqtLlFMX972MZZiv7hb67muin8/I0w+ENVfY0
         oMRADHJPwXBn6c9srzMfap1SWydvJEvSn/odKU0Fo/5VGD3I+YAL7ILXhwtsZU97vLjT
         ciN1MvlUAApugjuwvzyALjBkwjMmBqYORB/sN9jf5LEMVC8ow88PVgFVJ3YroGXSrO6d
         npG6yKUFEvLzzV53bQhzQfOYo2pyo/IHZuIpUZiVwdCeZ7gk8Z7Y0RB5xnLBThywF6bo
         VcZCZxKMtfDkgqbyV2/4Hyh0kswVEew+i1P9DeyL8s3FBjSyGBarjV4A4p4bWejksreQ
         rUMg==
X-Gm-Message-State: AOJu0YwFbj8Ytpw8O3KAUgrg7K9obry1bvsIXQWChToLilcexLaZ2LaY
	37Wu6tqS15/v0Kk/V7kWRU0fLEU/Zg+7r85AlLit8bsAEYmGOsrz3741QqUlad4G
X-Gm-Gg: Acq92OFw9Pe8BgkHHfy9y8zg7rp94YBUi/4Rf13HmypWa+UuDx7IOp93YX3BBTqPm0I
	jWlYuL7ufbKm89sc6AF9fQVI1Zl22KXEC3vms2xGOQ+peSkLqhSFc9EbmlUIDiKOHxxhbdBgHUg
	TEoxpCygG0MISY9QlVAMfvcuXyXJQaXkxhn0/J1sdJ1VFrfPaEHGNXlzQxcPJZmezLw1MxCGcRC
	1zlNqHyE5LCUDDIm8I/ax5phKQc5pLZTvYwhviuPzfX5cXOPbymf4kR7b1rH3mWVYpdVFfeQmRQ
	r9XC3rU/5hBMQOF/afEmATs6dncPaVXP/t+ga3ZBT2aYq3ub6HueB7fFbOoUIMSy3X+iSLjUrHv
	LZdACWhUjMZ0iKPefMW95+SHAohvl4UyCCqOfiXKFfTECLal9yxMIByhV7yqz2Wmkb+HLHOgKR1
	SXjUkwwLhJI/Rb/wb+KfFdnb093bkOpHqCaX8sVQo9tzSnxiaAJOVlzZjoR3SLUE29qqg1ypxdl
	pu4mMMM64HNat9YJU4X3/fRzaAV4cSXhK2i58BH1gdEmw==
X-Received: by 2002:a05:620a:488c:b0:8c9:f8e5:9f12 with SMTP id af79cd13be357-9158a83067amr328955885a.57.1780459368722;
        Tue, 02 Jun 2026 21:02:48 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3eea49sm127604285a.44.2026.06.02.21.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 21:02:48 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/2] watchdog: pika_wdt: portability and timer lifecycle fixes
Date: Tue,  2 Jun 2026 21:02:28 -0700
Message-ID: <20260603040230.318998-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace ppc4xx-specific MMIO accessors with portable helpers and
fix two high-severity timer bugs: a UAF on module exit (timer
fires after iounmap) and a close race that defeats the watchdog
reset on unexpected daemon termination.

v2: fix preexisting issues

Rosen Penev (2):
  watchdog: pika_wdt: fix timer leak and close race
  watchdog: pika_wdt: replace in_be32/out_be32 with
    ioread32be/iowrite32be

 drivers/watchdog/Kconfig    |  3 ++-
 drivers/watchdog/pika_wdt.c | 14 ++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

--
2.54.0

