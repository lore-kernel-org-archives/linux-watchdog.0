Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F150A45D937
	for <linux-watchdog@vger.kernel.org>; Fri,  2 Oct 2026 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929945; cv=none; b=Xa7c6+04TOFNUYIKt8hmf7sBjoGmSJJ021O2k99kYoRK9K69fcG7xy2GRxWLwkiivGxT5nthG1uvLaoU57aZU6uTM6BBWdL6mofLBrMgiJd5fkM1BqCn+saCzfwVZlNyczFWIYjDe5+3mFwcGz1OLQbTvlnII7kudAPVlooMV7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929945; c=relaxed/simple;
	bh=rm25fPbnkxJO7HK0YmIVPZ5xoj6VizjjzCiLuZ4wrBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D3uGhPVS4TsEiqu1I1rYv2wBp/DbobbC1OFjsgnWrHIc03meSydrvGS4axptjArovxxsIzJfCBiEjlo5K5AizwXXeHzKkLAT8C39sQKjVfE71xjHceHOyi7HlXVEOj/R4aFp67S7oXDU0PPV1KvC3yfL/SkMqL/kF0E2SV432aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gOM8/Y/X; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gOM8/Y/X"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff9621c5dso46616775e9.0
        for <linux-watchdog@vger.kernel.org>; Fri, 02 Oct 2026 01:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790929941; x=1791534741; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/bn76FEyPAPXjCUYSZydeUnbTPozt7o+Jc45Ge3nFyQ=;
        b=gOM8/Y/X8QSRBJid0XZciWOdROVf+RMhL25AJV8yolknw87gSL5S/vwYMGFwT7H5hA
         qXGE9lSVooIes0Vc4UgAG3LG/BZ9xd4DNEI8yalLTbWdnK7zo9E3qC4sQh/WZsg4g+ew
         TG7vz7RjF0PXObU4LdFW+flyGSQAjElyrsiKimXf/Q7jeIyF6NdrWu8uAkgciAuvZWUo
         OBv+8tLd9uDIxz+IKaeOrk3a4nX0buiJNmpeFmfK40wb3okDczzjrmsX/z5dAlEIMczF
         Kckecudd1heVZnr6LXfMIgW2ybIFHdyDhajsaW9wnpYlPuRYwPKB9CVqflmDPXEMfUBh
         lKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790929941; x=1791534741;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/bn76FEyPAPXjCUYSZydeUnbTPozt7o+Jc45Ge3nFyQ=;
        b=X4tYqgmLsNtkBAUmjIHHULQDtZmwx+VXTza8snNcfNUut9S2HpbQ0kRWI6y2OYsDye
         +RN0v/9hPdCW9zFs2KD5LjnhqGabXjCS14YfRZWsWxAzSbls/vJW8+7BkEnb+k5Hni46
         ocuIgpLiLQVUIKbWFcKmlKdp86UgUvGl4be8Uxzh2phaOq96eLG03gEIBEDJ8f6e7CWG
         DfSkzxh8YSFYoOWvbDPiZ+RdQ5mhrlxm/kDecKfH5g1KWipM3brfHwJetWYlp24obg+X
         cWi62gA4eGZTyh3j1kCXod2DQ9D6YjxE8hhBpaByPb0BcrlBAb/6T+0VRTUcrXq66dk5
         z/BA==
X-Forwarded-Encrypted: i=1; AKwUvBzCRGjDlYyiFVmJ3fIWQ4TgiOjVyRaOa58g0Kp0wPfMVOaRQwTXg0itUPk1gLppyZCUTN/BdfQbRrBGFGXFRg==@vger.kernel.org
X-Gm-Message-State: AFuF++n02CJTc02L2lroQB9ZgJIAAocKdrkJLZprQcRYZWCv0pt2FOe7
	iWi4ErnWM/K2rSMWkpakwvTH504hIvYyBBzq8wzuyUKg5ZBDvabVKMTW0PxqBnbDxNI=
X-Gm-Gg: AYBFou1LRUWI/W7xXsKl2GEeaphJuRz6wp6NHaylW5g0oHQZrzta7IWbIXGRJ7QYW5p
	XMD5DSw6JNiBkDeM1lJQFmKAbxSNS9/21F3XsMVyvp2zxpuEQ8w1bP+edaJpydlT+rCuH4YX4h4
	/3gNE0N2UyWfURQQMQ1uhPUIjk6xjG7Omb9k4JOLqCrrIquKW9m9Khp4GooRSy0WRdfYU8ireVo
	2itk4/FIQgrV2XfVKhpalQf7TG2gd4HWhzxQOCuI17i+qszkccagHZRgi1b4+AIVsMGV82EMG+Y
	rJ5gxwNGmcdOV1KfTCWYYF/0sr0jHgEspkJzVqvNCu42QoETW8ngdys6O0om+AvpGwnbVL2u3da
	ChuyJomTcPmn8aKLHwPO4L5qb9btlggFOTIo5tTODUm2cNIIoUgUZ4hWJdD4Kmh2SsD/3l40NTl
	u0oLF3UrVi5iCSvLTMNo/70efNGr2dW+XPV1CWzJoF3bOWUfT8GsKOkTlTViXiMPS/NQ==
X-Received: by 2002:a05:600c:4e41:b0:49c:e27c:6b10 with SMTP id 5b1f17b1804b1-4a0274f9bfbmr42577955e9.3.1790929940907;
        Fri, 02 Oct 2026 01:32:20 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03feed16bsm42507905e9.4.2026.10.02.01.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:32:20 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rudolf Marek <r.marek@assembler.cz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Duncan Sands <duncan.sands@free.fr>,
	Chas Williams <3chas3@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-watchdog@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Remove obsolete __MODULE_STRING()
Date: Fri,  2 Oct 2026 10:31:00 +0200
Message-ID: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260919-module-string-d64816f203d9
Content-Transfer-Encoding: 8bit

__MODULE_STRING() has been an alias for __stringify() since "[PATCH]
MODULE_PARM support for older modules" [1] in 2002-12. That change also
moved it to the graveyard section at the end of linux/module.h

Replace the remaining uses of __MODULE_STRING() with __stringify() and
remove the macro.

Apologies for the wide distribution. Acked-bys are appreciated.

[1] https://git.kernel.org/tglx/history/c/136839a1b4

---
Changes in v2:
- Rebase on top of next-20260930.
- Drop 'watchdog: Replace __MODULE_STRING() with __stringify()' since it
  has already been queued on watchdog-next.
- Split the hwmon changes into a separate patch.
- Link to v1: https://patch.msgid.link/20260922-module-string-v1-0-c18766690185@suse.com

---
Petr Pavlu (3):
      hwmon: Replace __MODULE_STRING() with __stringify()
      drivers: Replace __MODULE_STRING() with __stringify()
      module: Remove obsolete __MODULE_STRING()

 drivers/comedi/comedi_fops.c                          |  5 +++--
 drivers/gpu/drm/drm_fb_helper.c                       |  3 ++-
 drivers/hwmon/fschmd.c                                |  3 ++-
 drivers/hwmon/nct7904.c                               |  5 +++--
 drivers/hwmon/sch56xx-common.c                        |  3 ++-
 drivers/hwmon/w83793.c                                |  5 +++--
 drivers/i2c/busses/i2c-kempld.c                       |  3 ++-
 drivers/net/ethernet/atheros/atl1e/atl1e_param.c      |  9 +++++----
 drivers/net/ethernet/atheros/atlx/atl1.c              |  3 ++-
 drivers/net/ethernet/atheros/atlx/atl2.c              | 11 ++++++-----
 drivers/net/ethernet/intel/e1000/e1000_param.c        | 15 ++++++++-------
 drivers/net/ethernet/intel/e1000e/param.c             | 16 ++++++----------
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_param.c |  7 ++++---
 drivers/platform/cznic/turris-omnia-mcu-watchdog.c    |  3 ++-
 drivers/rtc/rtc-ds1374.c                              |  3 ++-
 drivers/thunderbolt/tb.c                              |  3 ++-
 drivers/thunderbolt/tunnel.c                          |  5 +++--
 drivers/tty/serial/8250/8250_platform.c               |  3 ++-
 drivers/usb/atm/speedtch.c                            | 15 ++++++++-------
 drivers/usb/atm/usbatm.c                              | 17 +++++++++--------
 include/linux/module.h                                |  4 ----
 21 files changed, 76 insertions(+), 65 deletions(-)
---
base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
change-id: 20260919-module-string-d64816f203d9
