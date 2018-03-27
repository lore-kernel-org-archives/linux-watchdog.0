Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36951 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeC0IKE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 27 Mar 2018 04:10:04 -0400
Received: by mail-lf0-f41.google.com with SMTP id m16-v6so28225487lfc.4
        for <linux-watchdog@vger.kernel.org>; Tue, 27 Mar 2018 01:10:03 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Subject: [PATCH 0/1] watchdog: core: add option to make timeouts read-only
Date: Tue, 27 Mar 2018 10:09:40 +0200
Message-Id: <20180327080941.29235-1-marcus.folkesson@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

I have encountered at least two projects (automotive) where there is a
strong demand for no-one to touch the configuration of the watchdog
timer once started.

File permissions and other restrictions has not been enough to satisfy
the requirement.

There you have some background information for this patch.

Cheers,
Marcus Folkesson


